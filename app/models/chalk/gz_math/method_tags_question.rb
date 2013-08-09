# encoding: utf-8

class Chalk::GzMath::MethodTagsQuestion < Chalk::Base
  # extends ...................................................................

  # includes ..................................................................
  include EnumI18n

  # security (i.e. attr_accessible) ...........................................
  attr_accessible :exam_exercise_id, :question_method_tag_id,
    :sub_question_type_tag_id, :question_type_tag_id

  # relationships .............................................................
  belongs_to :exam_exercise, class_name: "GzMath::ExamExercise"
  belongs_to :question_method_tag, class_name: "GzMath::QuestionMethodTag"
  belongs_to :sub_question_type_tag, class_name: "GzMath::SubQuestionTypeTag"
  belongs_to :question_type_tag, class_name: "GzMath::QuestionTypeTag"

  # constants definition ......................................................
  TABLE_NAME_PREFIX = "gz_math_"
  TABLE_NAME = "gz_math_method_tags_questions"

  # validations ...............................................................
  validates :question_method_tag_id, :exam_exercise_id, presence: true

  # callbacks .................................................................
  before_create :init_attributes

  # scopes ....................................................................

  # additional config .........................................................
  self.table_name_prefix = TABLE_NAME_PREFIX
  self.table_name = TABLE_NAME

  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................

  # private instance methods ..................................................
  private

  def init_attributes
    self.sub_question_type_tag_id = self.question_method_tag.sub_question_type_tag_id
    self.question_type_tag_id = self.sub_question_type_tag.question_type_tag_id
  end
end
