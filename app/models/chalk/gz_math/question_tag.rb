# encoding: utf-8

class Chalk::GzMath::QuestionTag < Chalk::Base
  # extends ...................................................................
  # includes ..................................................................
  #include ActiveModel::ForbiddenAttributesProtection

  # security (i.e. attr_accessible) ...........................................

  attr_accessible :content, :name, :type

  # relationships .............................................................
  # constants definition ......................................................
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................

  # public instance methods ...................................................
  def paper_questions(scope)
    exam_exercises.joins(exam_papers_sections_exercises: :exam_paper).
      select('gz_math_exam_exercises.id AS exercise_id, gz_math_exam_papers.id AS paper_id').
      where('gz_math_exam_papers.arts_science = ?', scope).map {|el| [el.paper_id, el.exercise_id]}
  end

  def question_count(scope)
    paper_questions(scope).count
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
