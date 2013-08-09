# encoding: utf-8

class Chalk::GzMath::ExamSection < Chalk::Base
  # extends ...................................................................

  # includes ..................................................................
  include ActiveModel::ForbiddenAttributesProtection
  include TarActivity

  include OrderIdx
  order_idx_scope [:exam_paper_id]

  # relationships .............................................................
  belongs_to :exam_paper, class_name: 'GzMath::ExamPaper'
  has_many :exam_papers_sections_exercises,
    class_name: 'GzMath::ExamPapersSectionsExercise',
    order: 'no_in_paper ASC', dependent: :destroy
  has_many :exam_exercises, class_name: 'GzMath::ExamExercise',
    through: :exam_papers_sections_exercises

  # constants definition ......................................................
  CATEGORY = Chalk::Enum.new(
    choice: 1,
    filling: 2,
    answering: 3,
    additional: 4
  )

  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................

  # public instance methods ...................................................

  def to_s
    title
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
