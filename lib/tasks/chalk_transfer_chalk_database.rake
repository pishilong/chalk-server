#encoding: utf-8

namespace :chalk do
  task 'transfer_chalk_database' => :environment do
    puts "transfer_chalk_database start"
    init_exam_categories
    backup_chalk_exam_papers
    puts "transfer_chalk_database end"
    #puts "--- NOTE: pending tasks: ---"
    #puts "  ng:pending_task_001"
  end

  def init_exam_categories
    return if ExamCategory.exists?
    categories = {
      '中考' => ['语文', '数学', '英语', '物理', '化学', '政治', '历史'],
      '高考' => ['语文', '数学', '英语', '理综', '物理', '化学', '生物',
        '文综', '政治', '历史', '地理'],
      'CET4' => ['英语'],
      'CET6' => ['英语'],
      '考研' => ['数学', '英语', '政治']
    }
    categories.each do |exam_type, subjects|
      subjects.each do |subject|
        ExamCategory.create!(exam_type: exam_type, subject: subject)
      end
    end
  end

  def backup_chalk_exam_papers
    backup_chalk_cet_exam_papers
    generate_cet_study_resources
  end

  def backup_chalk_cet_exam_papers
    Chalk::ExamPaper.all.each do |exam_paper|
      next if ExamPaperExtension.where(
        source_paper_id: exam_paper.source_paper_id,
        name: exam_paper.name
      ).exists?

      exam_category = exam_paper.exam_category
      ## Create QuestionContainer
      if exam_paper.status == Chalk::ExamPaper::STATUS['已禁用'] ||
        exam_paper.process_status == Chalk::ExamPaper::PROCESS_STATUS['已禁用']
        container_status = QuestionContainer::STATUS['禁用']
        forbidden_note = exam_paper.forbidden_note
      else
        container_status = QuestionContainer::STATUS['正常']
        forbidden_note = nil
      end

      question_container = QuestionContainer.create!(
        exam_category_id: exam_category.id,
        source_type: QuestionContainer::SOURCE_TYPE['真题考卷'],
        status: container_status, forbidden_note: forbidden_note)

      ## Create ExamPaperExtension
      exam_paper_extension = ExamPaperExtension.create!(
        question_container_id: question_container.id,
        source_paper_id: exam_paper.source_paper_id,
        import_status: exam_paper.status_str,
        process_status: exam_paper.process_status_str,
        name: exam_paper.name,
        description: exam_paper.description,
        year: exam_paper.year,
        month: exam_paper.month,
        source: exam_paper.source_str,
        region_type: exam_paper.region_type_str,
        province_id: exam_paper.province_id,
        city_id: exam_paper.city_id,
        district_id: exam_paper.district_id,
        paper_no: exam_paper.paper_no,
        duration: 7500)

      ## Create QuestionSection
      max_level = exam_paper.exam_paper_structures.maximum(:level)
      exam_paper.child_exam_paper_structures.each do |structure|
        question_section = duplicate_cet_exam_paper_structure(structure, nil, question_container)
        backup_cet_exam_paper_structure(structure, question_section, max_level)
      end
    end
  end

  def backup_cet_exam_paper_structure(structure, section, max_level)
    if structure.exam_paper_structures.exists?
      structure.exam_paper_structures.order("order_index ASC").each do |child|
        question_section = duplicate_cet_exam_paper_structure(child, section, nil)
        backup_cet_exam_paper_structure(child, question_section, max_level)
      end
    else
      if structure.level < max_level
        parent_section = section
        (max_level - structure.level).times do
          parent_section = virtual_cet_exam_paper_structure(parent_section, nil)
        end
        parent_section = duplicate_cet_exam_paper_structure(structure, parent_section, nil)
        backup_cet_exam_paper_exercises_and_questions(structure, parent_section)
      else
        backup_cet_exam_paper_exercises_and_questions(structure, section)
      end
    end
  end

  def duplicate_cet_exam_paper_structure(structure, section, question_container)
    if section
      question_container_id = section.question_container_id
      p_id = section.id
    elsif question_container
      question_container_id = question_container.id
      p_id = nil
    end
    question_section = QuestionSection.create!(
      question_container_id: question_container_id,
      section_type: structure.structure_type,
      p_id: p_id,
      title: structure.title,
      matched_title: structure.matched_title,
      description: structure.description,
      virtual: structure.virtual
    )

    question_section
  end

  def virtual_cet_exam_paper_structure(section, question_container)
    if section
      question_container_id = section.question_container_id
      p_id = section.id
    elsif question_container
      question_container_id = question_container.id
      p_id = nil
    end
    question_section = QuestionSection.create!(
      question_container_id: question_container_id,
      section_type: nil,
      p_id: p_id,
      title: nil,
      matched_title: nil,
      description: nil,
      virtual: true
    )

    question_section
  end

  def backup_cet_exam_paper_exercises_and_questions(structure, section)
    structure.exam_paper_exercises.order("order_index ASC").each do |exercise|
      parent_question = duplicate_cet_exam_paper_exercise(section, exercise)
      exercise.exam_paper_questions.order("order_index ASC").each do |question|
        duplicate_cet_exam_paper_question(parent_question, question)
      end
    end
  end

  def duplicate_cet_exam_paper_exercise(section, exercise)
    if ["短对话听力", "长对话听力", "短文听力"].include?(exercise.exercise_type)
      material = exercise.material
    else
      material = exercise.content
    end
    question = Question.create!(
      exam_category_id: section.exam_category_id,
      question_type: exercise.exercise_type,
      p_id: nil,
      number: exercise.matched_title,
      title: exercise.title,
      description: exercise.description,
      material: material,
      options: exercise.options,
      process_status: exercise.process_status_str,
      processing_user_id: exercise.processing_user_id,
      processing_at: exercise.processing_at
    )

    QuestionSection.create!(
      question_container_id: section.question_container_id,
      section_type: nil,
      p_id: section.id,
      title: nil,
      matched_title: nil,
      description: nil,
      virtual: false,
      question_id: question.id,
      number: exercise.matched_title,
      score: nil #exercise.structured_scores
    )

    question
  end

  def duplicate_cet_exam_paper_question(parent_question, chalk_question)
    question_content = QuestionContent.create!(
      answer_type: chalk_question.answer_type,
      difficulty: chalk_question.difficulty,
      content: chalk_question.content,
      answer: chalk_question.answer,
      analysis: chalk_question.analysis,
      fallible_point: chalk_question.fallible_point,
      option_a: chalk_question.option_a,
      option_b: chalk_question.option_b,
      option_c: chalk_question.option_c,
      option_d: chalk_question.option_d,
      option_e: chalk_question.option_e
    )

    #scope_knowledge = xxx # find the scope knowledge
    question = Question.create!(
      exam_category_id: parent_question.exam_category_id,
      question_type: chalk_question.question_type,
      p_id: parent_question.id,
      number: chalk_question.no_in_paper,
      title: nil,
      description: nil,
      material: nil,
      options: chalk_question.options,
      process_status: chalk_question.process_status_str,
      #processing_user_id: chalk_question.processing_user_id,
      #processing_at: chalk_question.processing_at,
      #scope_id: scope_knowledge.id,
      question_content_id: question_content.id
    )

    question
  end

  def generate_cet_study_resources
  end
end
