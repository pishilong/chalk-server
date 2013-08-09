# encoding: utf-8

class Chalk::GzMath::ExamExercise < Chalk::Base
  # extends ...................................................................

  # includes ..................................................................
  include ActiveModel::ForbiddenAttributesProtection
  include TarActivity

  # relationships .............................................................
  belongs_to :processing_user, class_name: "TarUser"
  has_many :exam_papers_sections_exercises,
    class_name: 'GzMath::ExamPapersSectionsExercise', dependent: :destroy
  belongs_to :question_type_tag, class_name: "GzMath::QuestionTypeTag"
  belongs_to :sub_question_type_tag, class_name: "GzMath::SubQuestionTypeTag"

  has_many :method_tags_questions, class_name: "GzMath::MethodTagsQuestion", :dependent => :destroy
  has_many :question_method_tags, through: :method_tags_questions
  has_many :other_tags_questions, class_name: "GzMath::OtherTagsQuestion", :dependent => :destroy
  has_many :other_tags, through: :other_tags_questions

  has_one :option_analysis, class_name: "GzMath::OptionAnalysis"
  has_many :solving_idea_tag_exercises, class_name: "GzMath::SolvingIdeaTagExercise"
  has_many :solving_idea_tags, class_name: "GzMath::SolvingIdeaTag", through: :solving_idea_tag_exercises

  has_many :solving_method_tag_exercises, class_name: "GzMath::SolvingMethodTagExercise"
  has_many :solving_method_tags, class_name: "GzMath::SolvingMethodTag", through: :solving_method_tag_exercises

  has_many :fallible_point_tag_exercises, class_name: "GzMath::FalliblePointTagExercise"
  has_many :fallible_point_tags, class_name: "GzMath::FalliblePointTag", through: :fallible_point_tag_exercises

  has_many :key_step_tag_exercises, class_name: "GzMath::KeyStepTagExercise"
  has_many :key_step_tags, class_name: "GzMath::KeyStepTag", through: :key_step_tag_exercises

  has_many :feature_tag_exercises, class_name: "GzMath::FeatureTagExercise"
  has_many :feature_tags, class_name: "GzMath::FeatureTag", through: :feature_tag_exercises

  has_many :keypoints_exam_exercises, class_name: "GzMath::KeypointsExamExercise", foreign_key: 'exercise_id'

  # constants definition ......................................................
  CATEGORY = Chalk::Enum.new(
    choice: 1,
    filling: 2,
    answering: 3,
    additional: 4
  )

  PROCESS_STATUS = Chalk::Enum.new({
    '未处理' => 0,
    '一轮处理中' => 10,
    '一轮处理完毕' => 20,
    '二轮处理中' => 30,
    '二轮处理完毕' => 40,
  })

  ANALYSIS_MODE = Chalk::Enum.new({
    '模式一' => 1,
    '模式二' => 2,
    })

  TAG_TYPE = Chalk::Enum.new({
    '解题思想' => 'solving_idea',
    '解题方法' => 'solving_method',
    '易错点' => 'fallible_point',
    '关键步骤' => 'key_step',
    '题设特点' => 'feature',
    '其他' => 'other_type'
    })

  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  scope :choice, -> { where(category: CATEGORY[:choice]) }
  scope :sentence_completion, -> { where(category: CATEGORY[:filling]) }
  scope :solution, -> { where(category: CATEGORY[:answering]) }
  scope :additional, -> { where(category: CATEGORY[:additional]) }

  # additional config .........................................................

  # 自动 strip 且空字符串看做 nil 处理
  normalize_attributes :option_a, :option_b, :option_c, :option_d, :answer,
    :analysis, :solution, :comment, :analysis_mode

  # class methods .............................................................

  # public instance methods ...................................................
  def no_in_paper(paper = nil)
    if paper
      self.exam_papers_sections_exercises.where(exam_paper_id: paper.id).first.no_in_paper
    else
      # TODO
      self.exam_papers_sections_exercises.first.no_in_paper
    end
  end

  def to_s
    "#{no_in_paper}. #{(content || '').first(10)}"
  end

  def first_round_complete?
    self.process_status == self.class.const_get('PROCESS_STATUS').value('一轮处理完毕')
  end

  def choice?
    self.category == 1
  end

  def prepare_keypoints_exercises(paper)
    self.exam_papers_sections_exercises.where(exam_paper_id: paper.id).first.keypoints_exercises.order('order_idx ASC')
  end

  def keypoints_exercises(paper, option)
    second_keypoint_mode = GzMath::KeypointsExercise::KEYPOINT_MODE['模式二']
    relation = prepare_keypoints_exercises(paper)
    option.blank? ? relation.where("keypoint_mode != ?", second_keypoint_mode) :
      relation.where(keypoint_mode: second_keypoint_mode, keypoint_option: option)
  end

  def keypoints_exercise_second_mode?(paper)
    prepare_keypoints_exercises(paper).last && prepare_keypoints_exercises(paper).last.keypoint_mode == GzMath::KeypointsExercise::KEYPOINT_MODE['模式二']
  end

  def selectable_question_type_tags
    GzMath::QuestionTypeTag.where('name IS NOT NULL').
      order('name ASC').uniq.pluck(:name)
  end

  def selectable_sub_question_type_tags
    return [] if question_type_tag.nil?
    question_type_tag.sub_question_type_tags.where('name IS NOT NULL').
      order('name ASC').uniq.pluck(:name)
  end

  def selectable_question_method_tags
    return [] if sub_question_type_tag.nil?
    sub_question_type_tag.question_method_tags.where('name IS NOT NULL').
      order('name ASC').select{|c| !question_method_tags.include?(c)}.
      map {|c| [c.name, c.id]}
  end

  def selectable_other_type_tags
    GzMath::OtherTypeTag.where('name IS NOT NULL').
      order('name ASC').map{|c| [c.name, c.id]}
  end

  def single_selectable_other_type_tags
    GzMath::OtherTypeTag.where('name IS NOT NULL').
      order('name ASC').uniq.pluck(:name)
  end

  def question_type_tag_name
    question_type_tag.nil? ? '' : question_type_tag.name
  end

  def sub_question_type_tag_name
    sub_question_type_tag.nil? ? '' : sub_question_type_tag.name
  end

  def in_round?(round)
    if round == 1
      self.process_status == self.class.const_get('PROCESS_STATUS').value('未处理') ||
        self.process_status == self.class.const_get('PROCESS_STATUS').value('一轮处理中')
    elsif round == 2
      # 二轮处理允许往复处理
      self.process_status == self.class.const_get('PROCESS_STATUS').value('一轮处理完毕') ||
        self.process_status == self.class.const_get('PROCESS_STATUS').value('二轮处理中') ||
        self.process_status == self.class.const_get('PROCESS_STATUS').value('二轮处理完毕')
    else
      raise "round should be 1 or 2, not #{round}"
    end
  end

  def first_round_complete?
    self.process_status == self.class.const_get('PROCESS_STATUS').value('一轮处理完毕')
  end

  def second_round_complete?
    self.process_status == self.class.const_get('PROCESS_STATUS').value('二轮处理完毕')
  end

  def complete_current_round?(round)
    round == 1 ? first_round_complete? : second_round_complete?
  end

  def option_analysis_preprocess(params = {})
    if self.option_analysis
      self.option_analysis.update_attributes(params)
    else
      self.create_option_analysis(params)
    end
  end

  def feature_tag_text(question_tag)
    fte = feature_tag_exercises.where(
      'feature_tag_id' => question_tag.id).first
    if fte
      [fte.condition_text, fte.solving_text].compact.join('/')
    else
      ''
    end
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
