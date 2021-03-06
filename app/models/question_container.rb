# encoding: utf-8

class QuestionContainer < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................
  #include ActiveModel::ForbiddenAttributesProtection
  #include TarActivity

  # security (i.e. attr_accessible) ...........................................
  attr_accessible :exam_category_id, :source_type, :status, :forbidden_note

  # relationships .............................................................
  belongs_to :exam_category

  has_one :exam_paper_extension
  has_many :question_sections, :dependent => :destroy

  # constants definition ......................................................
  SOURCE_TYPE = Chalk::Enum.new %w(真题考卷 自组试卷)

  STATUS = Chalk::Enum.new %w(正常 禁用)

  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
end
