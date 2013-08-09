# encoding: utf-8

class Chalk::GzMath::QuestionTypeTag < Chalk::Base
  # extends ...................................................................

  # includes ..................................................................
  include EnumI18n

  # security (i.e. attr_accessible) ...........................................
  attr_accessible :name, :description

  # relationships .............................................................
  has_many :sub_question_type_tags, class_name: "GzMath::SubQuestionTypeTag", :dependent => :destroy
  has_many :question_method_tags, through: :sub_question_type_tags
  has_many :method_tags_questions, class_name: "GzMath::MethodTagsQuestion"
  has_many :exam_paper_questions, through: :method_tags_questions

  # constants definition ......................................................
  TABLE_NAME_PREFIX = "gz_math_"
  TABLE_NAME = "gz_math_question_type_tags"

  # validations ...............................................................
  validates :name, presence: true

  # callbacks .................................................................
  # scopes ....................................................................

  # additional config .........................................................
  self.table_name_prefix = TABLE_NAME_PREFIX
  self.table_name = TABLE_NAME

  # class methods .............................................................
    def self.name_list
      GzMath::QuestionTypeTag.where('name IS NOT NULL')
        .select([:id, :name]).map{ |item| [item.name, item.id] }
    end

  # public instance methods ...................................................
  def method_tags_count
    count = sub_question_type_tags.sum { |t| t.method_tags_count }
    (count > 0) ? count : 1
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
