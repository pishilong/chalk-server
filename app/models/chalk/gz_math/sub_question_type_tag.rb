# encoding: utf-8

class Chalk::GzMath::SubQuestionTypeTag < Chalk::Base
  # extends ...................................................................

  # includes ..................................................................
  include EnumI18n

  # security (i.e. attr_accessible) ...........................................
  attr_accessible :question_type_tag_id, :name, :description

  # relationships .............................................................
  belongs_to :question_type_tag, class_name: "GzMath::QuestionTypeTag"
  has_many :question_method_tags, class_name: "GzMath::QuestionMethodTag", :dependent => :destroy
  has_many :method_tags_questions, class_name: "GzMath::MethodTagsQuestion"
  has_many :exam_paper_questions, through: :method_tags_questions

  # constants definition ......................................................
  TABLE_NAME_PREFIX = "gz_math_"
  TABLE_NAME = "gz_math_sub_question_type_tags"

  # validations ...............................................................
  validates :question_type_tag_id, :name, presence: true

  # callbacks .................................................................

  # scopes ....................................................................

  # additional config .........................................................
  self.table_name_prefix = TABLE_NAME_PREFIX
  self.table_name = TABLE_NAME

  # class methods .............................................................

  # public instance methods ...................................................
  def first_question_type_tag_child?
    question_type_tag.sub_question_type_tags.first == self
  end

  def method_tags_count
    count = question_method_tags.count
    (count > 0) ? count : 1
  end

  # protected instance methods ................................................

  # private instance methods ..................................................
end
