# encoding: utf-8

class Chalk::GzMath::OtherTag < Chalk::Base
  # extends ...................................................................

  # includes ..................................................................
  include EnumI18n

  # security (i.e. attr_accessible) ...........................................
  attr_accessible :other_type_tag_id, :name, :content

  # relationships .............................................................
  belongs_to :other_type_tag, class_name: "GzMath::OtherTypeTag"
  has_many :other_tags_questions, class_name: "GzMath::OtherTagsQuestion", :dependent => :destroy
  has_many :exam_exercises, through: :other_tags_questions

  # constants definition ......................................................
  TABLE_NAME_PREFIX = "gz_math_"
  TABLE_NAME = "gz_math_other_tags"

  # validations ...............................................................
  validates :other_type_tag_id, :name, presence: true

  # callbacks .................................................................

  # scopes ....................................................................

  # additional config .........................................................
  self.table_name_prefix = TABLE_NAME_PREFIX
  self.table_name = TABLE_NAME

  # class methods .............................................................

  # public instance methods ...................................................
  def other_type_tag_name
    other_type_tag.nil? ? '' : other_type_tag.name
  end

  def fresh?(question)
    question_ids = other_tags_questions.map{ |r| r.exam_exercise_id }.uniq
    (question_ids - [question.id]).empty?
  end

  def first_other_type_tag_child?
    other_type_tag.other_tags.first == self
  end

  def full_name(link_label = ' >> ')
    result = [other_type_tag.name, self.name]
    return result.join(link_label)
  end

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
