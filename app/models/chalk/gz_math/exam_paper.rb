# encoding: utf-8

class Chalk::GzMath::ExamPaper < Chalk::Base
  # extends ...................................................................

  # includes ..................................................................
  include ExamPaperBase
  include ActiveModel::ForbiddenAttributesProtection
  include TarActivity
  include EnumI18n

  # relationships .............................................................
  has_many :exam_sections, class_name: 'GzMath::ExamSection',
    order: 'order_idx ASC', dependent: :destroy
  has_many :exam_papers_sections_exercises,
    class_name: 'GzMath::ExamPapersSectionsExercise',
    order: 'no_in_paper ASC', dependent: :destroy
  has_many :exam_exercises, class_name: 'GzMath::ExamExercise',
    through: :exam_papers_sections_exercises
  belongs_to :province

  # constants definition ......................................................
  CATEGORY = Chalk::Enum.new(
    gaokao: 1
  )

  ARTS_SCIENCE = Chalk::Enum.new(
    arts: 1,
    science: 2,
    general: 3
  )

  PROCESS_STATUS = Chalk::Enum.new({
    '一轮处理中' => 40,
    '一轮处理完毕' => 50,
    '二轮处理中' => 60,
    '二轮处理完毕' => 70
  })

  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................

  # public instance methods ...................................................
  def choice_exercises
    exam_exercises.choice.order('no_in_paper ASC')
  end

  def sentence_completion_exercises
    exam_exercises.sentence_completion.order('no_in_paper ASC')
  end

  def solution_exercises
    exam_exercises.solution.order('no_in_paper ASC')
  end

  def province_name
    province ? province.name : '(全国)'
  end

  def to_s
    title
  end

  def format_name
    "#{year} #{province_name}"
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
