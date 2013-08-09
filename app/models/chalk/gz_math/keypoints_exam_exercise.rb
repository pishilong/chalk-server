# encoding: utf-8

class Chalk::GzMath::KeypointsExamExercise < Chalk::Base
  # extends ...................................................................
  # includes ..................................................................
  #include ActiveModel::ForbiddenAttributesProtection

  # security (i.e. attr_accessible) ...........................................

  attr_accessible :exercise_id, :keypoint_id, :keypoint_mode, :keypoint_option

  # relationships .............................................................

  belongs_to :keypoint, class_name: 'GzMath::Keypoint'
  belongs_to :exam_exercise, class_name: 'GzMath::ExamExercise'

  # constants definition ......................................................
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
end