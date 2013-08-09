# encoding: utf-8

class Chalk::GzMath::FeatureTag < Chalk::Base
  # extends ...................................................................
  # includes ..................................................................
  #include ActiveModel::ForbiddenAttributesProtection
  # security (i.e. attr_accessible) ...........................................

  attr_accessible :content, :name

  # relationships .............................................................

  has_many :feature_tag_exercises, class_name: "GzMath::FeatureTagExercise"
  has_many :exam_exercises, class_name: "GzMath::ExamExercise", through: :feature_tag_exercises

  # constants definition ......................................................
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................

  # public instance methods ...................................................
  def paper_questions(scope, common_type)
    relation = exam_exercises.joins(exam_papers_sections_exercises: :exam_paper).
      select('gz_math_exam_exercises.id AS exercise_id, gz_math_exam_papers.id AS paper_id').
      where('gz_math_exam_papers.arts_science = ?', scope)

    _common = GzMath::FeatureTagExercise::COMMON
    case common_type
    when _common['无']
      relation = relation.where("(gz_math_feature_tag_exercises.is_condition = ?\
        OR gz_math_feature_tag_exercises.is_condition IS NULL ) AND\
        (gz_math_feature_tag_exercises.is_solving = ? OR gz_math_feature_tag_exercises.is_solving IS NULL )",
        false, false).uniq
    when _common['已知条件共性']
      relation = relation.where("gz_math_feature_tag_exercises.is_condition = ?\
        AND (gz_math_feature_tag_exercises.is_solving = ? OR gz_math_feature_tag_exercises.is_solving IS NULL )",
        true, false).uniq
    when _common['求解目标共性']
      relation = relation.where("(gz_math_feature_tag_exercises.is_condition = ?\
        OR gz_math_feature_tag_exercises.is_condition IS NULL) AND gz_math_feature_tag_exercises.is_solving = ?",
        false, true).uniq
    when _common['已知条件共性/求解目标共性']
      relation = relation.where("gz_math_feature_tag_exercises.is_condition = ?\
        AND gz_math_feature_tag_exercises.is_solving = ?", true, true).uniq
    end
    relation.map {|el| [el.paper_id, el.exercise_id]}
  end

  def question_count(scope, common_type)
    paper_questions(scope, common_type).count
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
