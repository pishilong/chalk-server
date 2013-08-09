# encoding: utf-8

class Chalk::GzMath::QuestionMethodTag < Chalk::Base
  # extends ...................................................................

  # includes ..................................................................
  include EnumI18n

  # security (i.e. attr_accessible) ...........................................
  attr_accessible :question_type_tag_id, :sub_question_type_tag_id, :name, :content

  # relationships .............................................................
  belongs_to :question_type_tag, class_name: "GzMath::QuestionTypeTag"
  belongs_to :sub_question_type_tag, class_name: "GzMath::SubQuestionTypeTag"
  has_many :method_tags_questions, class_name: "GzMath::MethodTagsQuestion", :dependent => :destroy
  has_many :exam_paper_questions, through: :method_tags_questions

  # constants definition ......................................................
  TABLE_NAME_PREFIX = "gz_math_"
  TABLE_NAME = "gz_math_question_method_tags"

  # validations ...............................................................
  validates :sub_question_type_tag_id, :name, presence: true

  # callbacks .................................................................
  before_create :set_question_type_tag_id

  # scopes ....................................................................

  # additional config .........................................................
  self.table_name_prefix = TABLE_NAME_PREFIX
  self.table_name = TABLE_NAME

  # class methods .............................................................

  # public instance methods ...................................................
  def fresh?(question)
    question_ids = method_tags_questions.map{ |r| r.exam_exercise_id }.uniq
    (question_ids - [question.id]).empty?
  end

  def first_question_type_tag_child?
    first_sub_question_type_tag_child? &&
      sub_question_type_tag.first_question_type_tag_child?
  end

  def first_sub_question_type_tag_child?
    sub_question_type_tag.question_method_tags.first == self
  end

  def math_type_question_count(math_type)
    exam_paper_questions.where(math_type: math_type).count
  end

  def full_name(link_label = ' >> ')
    result = [question_type_tag.name, sub_question_type_tag.name, self.name]
    return result.join(link_label)
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
  private

  def set_question_type_tag_id
    self.question_type_tag_id = self.sub_question_type_tag.question_type_tag_id
    true
  end

end
