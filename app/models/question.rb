class Question < ActiveRecord::Base
  # extends ...................................................................

  # includes ..................................................................
  include OrderIdx
  order_idx_scope [:exam_category_id, :p_id]
  #include ActiveModel::ForbiddenAttributesProtection
  #include TarActivity

  # security (i.e. attr_accessible) ...........................................
  attr_accessible :exam_category_id, :question_type, :p_id, :level, :order_idx,
    :children_count, :number, :title, :description, :material, :options,
    :process_status, :processing_user_id, :processing_at, :question_content_id,
    :scope_id

  # relationships .............................................................
  belongs_to :exam_category
  belongs_to :question, foreign_key: :p_id
  belongs_to :question_content
  belongs_to :processing_user, class_name: "User"

  has_many :questions, foreign_key: :p_id
  has_many :question_sections

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
    if question
      self.level = question.level + 1
      self.exam_category_id = question.exam_category_id
    else
      self.level = 1
    end
  end
end
