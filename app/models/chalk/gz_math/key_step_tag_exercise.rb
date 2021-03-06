# encoding: utf-8

class Chalk::GzMath::KeyStepTagExercise < Chalk::Base
  # extends ...................................................................
  # includes ..................................................................
  #include ActiveModel::ForbiddenAttributesProtection

  # security (i.e. attr_accessible) ...........................................

  attr_accessible :exam_exercise_id, :key_step_tag_id

  # relationships .............................................................

  belongs_to :exam_exercise, class_name: "GzMath::ExamExercise"
  belongs_to :key_step_tag, class_name: "GzMath::KeyStepTag"

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
