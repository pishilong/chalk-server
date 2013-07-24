# encoding: utf-8

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
  ROOT_QUESTION_TEMPLATE = Chalk::Enum.new({
    '练习' => {value: 'Practice', '短对话听力' => 11, '长对话听力' => 11,
      '短文听力' => 11, '复合式听力' => 11, '选词填空' => 21, '快速阅读' => 31,
      '短文理解' => 31, '完形' => 31, '翻译' => 41, '作文' => 51},
    '测试' => {value: 'Examination', '短对话听力' => 12, '长对话听力' => 12,
      '短文听力' => 12, '复合式听力' => 12, '选词填空' => 22, '快速阅读' => 32,
      '短文理解' => 32, '完形' => 32, '翻译' => 42, '作文' => 52}
  })

  QUESTION_TEMPLATE_TYPE = Chalk::Enum.new({
    '普通' => 'normal',
    '左右' => 'left-right'
  })

  QUESTION_TEMPLATE = Chalk::Enum.new({
    '短对话听力' => {value: '短对话听力', '选择题' => 1, '单选题' => 1},
    '长对话听力' => {value: '长对话听力', '选择题' => 2, '单选题' => 2},
    '短文听力' => {value: '短文听力', '选择题' => 2, '单选题' => 2},
    '完形' => {value: '完形', '选择题' => 2, '单选题' => 2},
    '快速阅读' => {value: '快速阅读', '选择题' => 3, '单选题' => 3, '填空题' => 4,
      '精确填空题' => 4, '判断题' => 4},
    '短文理解' => {value: '短文理解', '选择题' => 3, '单选题' => 3},
    '复合式听力' => {value: '复合式听力', '精确填空题' => 5, '大意填空题' => 7},
    '翻译' => {value: '翻译', '填空题' => 6, '大意填空题' => 6},
    '作文' => {value: '作文', '作文题' => 9}
  })

  # validations ...............................................................

  # callbacks .................................................................
  before_create :init_attributes

  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................

  # public instance methods ...................................................
  def root_question
    if question
      question.root_question
    else
      self
    end
  end

  ## TODO
  def question_template_type(behavior_type)
    if exam_category.cet?
      if behavior_type == StudyResorce::BEHAVIOR_TYPE['练习']
        QUESTION_TEMPLATE_TYPE['左右']
      elsif behavior_type == StudyResorce::BEHAVIOR_TYPE['测试']
        QUESTION_TEMPLATE_TYPE['左右']
      end
    else
      if behavior_type == StudyResorce::BEHAVIOR_TYPE['练习']
        QUESTION_TEMPLATE_TYPE['普通']
      elsif behavior_type == StudyResorce::BEHAVIOR_TYPE['测试']
        QUESTION_TEMPLATE_TYPE['普通']
      end
    end
  end

  def question_template
    return nil if question_type.blank? || root_question.question_type.blank?
    QUESTION_TEMPLATE.value(root_question.question_type, question_type)
  end

  def root_question_template(behavior_type)
    behavior_type_key = ROOT_QUESTION_TEMPLATE.key(behavior_type)
    return nil if root_question.question_type.blank?
    ROOT_QUESTION_TEMPLATE.value(behavior_type_key, root_question.question_type)
  end

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
