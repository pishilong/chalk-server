# encoding: utf-8

class ExamCategory < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................
  #include ActiveModel::ForbiddenAttributesProtection
  #include TarActivity

  # security (i.e. attr_accessible) ...........................................
  attr_accessible :exam_type, :subject

  # relationships .............................................................
  has_many :question_containers
  has_many :question_sections
  has_many :questions
  has_many :knowledge_containers
  has_many :knowledge_trees
  has_many :knowledges
  has_many :keypoints

  has_many :study_resorces
  has_many :study_resorce_categories

  # constants definition ......................................................
  EXAM_TYPE = Chalk::Enum.new %w(中考 高考 CET4 CET6 考研)

  SUBJECT = Chalk::Enum.new %w(语文 数学 英语 理综 物理 化学 生物 文综 政治 历史 地理)

  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................

  # class methods .............................................................
  def self.cet4_exam_category
    ExamCategory.where(exam_type: ExamCategory::EXAM_TYPE['CET4'],
      subject: ExamCategory::SUBJECT['英语']).first
  end

  def self.cet6_exam_category
    ExamCategory.where(exam_type: ExamCategory::EXAM_TYPE['CET6'],
      subject: ExamCategory::SUBJECT['英语']).first
  end

  # public instance methods ...................................................
  def cet?
    exam_type == EXAM_TYPE['CET4'] || exam_type == EXAM_TYPE['CET6']
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
