# encoding: utf-8

class QuestionSection < ActiveRecord::Base
  # extends ...................................................................

  # includes ..................................................................
  include OrderIdx
  order_idx_scope [:exam_category_id, :question_container_id, :p_id]

  #include ActiveModel::ForbiddenAttributesProtection
  #include TarActivity

  # security (i.e. attr_accessible) ...........................................
  attr_accessible :exam_category_id, :question_container_id, :section_type,
    :p_id, :level, :order_idx, :overall_idx, :questions_count, :children_count,
    :title, :matched_title, :description, :virtual, :question_id, :score, :number

  # relationships .............................................................
  belongs_to :exam_category
  belongs_to :question_container
  belongs_to :question_section, foreign_key: :p_id
  belongs_to :question

  has_many :question_sections, foreign_key: :p_id, :dependent => :destroy
  has_many :questions, through: :question_sections

  # constants definition ......................................................
  # validations ...............................................................

  # callbacks .................................................................
  before_create :init_attributes

  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................

  # private instance methods ..................................................
  private

  def init_attributes
    if question_section
      self.level = question_section.level + 1
      self.exam_category_id = question_section.exam_category_id
      self.question_container_id = question_section.question_container_id
    elsif question_container
      self.level = 1
      self.exam_category_id = question_container.exam_category_id
    end
  end
end
