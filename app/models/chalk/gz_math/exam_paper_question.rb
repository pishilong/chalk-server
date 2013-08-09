# encoding: utf-8

class Chalk::GzMath::ExamPaperQuestion < Chalk::Base
  # extends ...................................................................

  # includes ..................................................................
  #include ExamPaperQuestionBase
  #include PublicActivity::Model
  #tracked owner: Proc.new{ |controller, model| controller && controller.current_tar_user }

  # security (i.e. attr_accessible) ...........................................
  attr_accessible :exam_paper_exercise_id, 
    :question_type, :no_in_paper, :content, :options, :option_a, :option_b,
    :option_c, :option_d, :option_e, :answer, :analysis, :order_index, :status,
    :process_status, :difficulty, :fallible_point,
    :question_type_tag_id, :sub_question_type_tag_id

  # relationships .............................................................
  belongs_to :exam_exercise, class_name: "GzMath::ExamExercise"
  belongs_to :question_type_tag, class_name: "GzMath::QuestionTypeTag"
  belongs_to :sub_question_type_tag, class_name: "GzMath::SubQuestionTypeTag"

  has_many :method_tags_questions, class_name: "GzMath::MethodTagsQuestion", :dependent => :destroy
  has_many :question_method_tags, through: :method_tags_questions
  has_many :other_tags_questions, class_name: "GzMath::OtherTagsQuestion", :dependent => :destroy
  has_many :other_tags, through: :other_tags_questions

  # constants definition ......................................................
  TABLE_NAME_PREFIX = "gz_math_"
  TABLE_NAME = "gz_math_exam_paper_questions"

  # validations ...............................................................

  # callbacks .................................................................
  after_save :delete_sub_question_type_tag, if: :question_type_tag_id_changed?
  after_save :delete_method_tags_questions, if: :sub_question_type_tag_id_changed?

  # scopes ....................................................................

  # additional config .........................................................
  self.table_name_prefix = TABLE_NAME_PREFIX
  self.table_name = TABLE_NAME

  # class methods .............................................................

  # public instance methods ...................................................
  def sibling_questions
    GzMath::ExamPaperQuestion.where(exam_exercise_id: self.exam_exercise_id)
  end

  def question_type_tag_name
    question_type_tag.nil? ? '' : question_type_tag.name
  end

  def sub_question_type_tag_name
    sub_question_type_tag.nil? ? '' : sub_question_type_tag.name
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

  # protected instance methods ................................................

  # private instance methods ..................................................
  private

  def delete_sub_question_type_tag
    self.update_column :sub_question_type_tag_id, nil
    self.method_tags_questions.destroy_all
  end

  def delete_method_tags_questions
    self.method_tags_questions.destroy_all
  end
end
