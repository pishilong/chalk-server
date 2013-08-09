# encoding: utf-8

class Chalk::GzMath::KeypointsExercise < Chalk::Base
  # extends ...................................................................

  # includes ..................................................................
  include OrderIdx
  order_idx_scope :exam_papers_sections_exercise_id

  include ActiveModel::ForbiddenAttributesProtection

  # relationships .............................................................
  belongs_to :keypoint, class_name: 'GzMath::Keypoint'
  belongs_to :exam_papers_sections_exercise,
    class_name: 'GzMath::ExamPapersSectionsExercise'

  # constants definition ......................................................

  KEYPOINT_MODE = Chalk::Enum.new(
    '模式一' => 1,
    '模式二' => 2,
  )

  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
end