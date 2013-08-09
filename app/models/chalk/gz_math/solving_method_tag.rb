# encoding: utf-8

class Chalk::GzMath::SolvingMethodTag < GzMath::QuestionTag
  # extends ...................................................................
  # includes ..................................................................
  #include ActiveModel::ForbiddenAttributesProtection
  # security (i.e. attr_accessible) ...........................................

  # relationships .............................................................

  has_many :solving_method_tag_exercises, class_name: "GzMath::SolvingMethodTagExercise"
  has_many :exam_exercises, class_name: "GzMath::ExamExercise", through: :solving_method_tag_exercises

  # constants definition ......................................................

  # validations ...............................................................

  validates :name, presence: true

  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................
  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
end