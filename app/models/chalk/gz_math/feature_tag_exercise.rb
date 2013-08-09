# encoding: utf-8

class Chalk::GzMath::FeatureTagExercise < Chalk::Base
  # extends ...................................................................
  # includes ..................................................................
  #include ActiveModel::ForbiddenAttributesProtection

  # security (i.e. attr_accessible) ...........................................

  attr_accessible :exam_exercise_id, :feature_tag_id, :is_condition, :is_solving

  # relationships .............................................................

  belongs_to :exam_exercise, class_name: "GzMath::ExamExercise"
  belongs_to :feature_tag, class_name: "GzMath::FeatureTag"

  # constants definition ......................................................
  COMMON = Chalk::Enum.new(
    :'无' => 'none',
    :'已知条件共性' => 'is_condition',
    :'求解目标共性' => 'is_solving',
    :'已知条件共性/求解目标共性' => 'condition_solving',
  )

  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................

  # public instance methods ...................................................

  def condition_text
    is_condition ? '已知条件共性' : nil
  end

  def solving_text
    is_solving ? '求解目标共性' : nil
  end

  def feature_tag_text
    [condition_text, solving_text].compact.join('/')
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
