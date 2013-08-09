# encoding: utf-8

class Chalk::GzMath::OtherTypeTag < Chalk::Base
  # extends ...................................................................

  # includes ..................................................................
  include EnumI18n

  # security (i.e. attr_accessible) ...........................................
  attr_accessible :name, :description

  # relationships .............................................................
  has_many :other_tags, class_name: "GzMath::OtherTag", :dependent => :destroy
  has_many :other_tags_questions, class_name: "GzMath::OtherTagsQuestion"
  has_many :exam_exercises, through: :other_tags_questions

  # constants definition ......................................................
  TABLE_NAME_PREFIX = "gz_math_"
  TABLE_NAME = "gz_math_other_type_tags"

  # validations ...............................................................
  validates :name, presence: true

  # callbacks .................................................................
  # scopes ....................................................................

  # additional config .........................................................
  self.table_name_prefix = TABLE_NAME_PREFIX
  self.table_name = TABLE_NAME

  # class methods .............................................................
  def self.name_list
    GzMath::OtherTypeTag.where('name IS NOT NULL')
      .select([:id, :name]).map{ |ot| [ot.name, ot.id] }
  end

  # public instance methods ...................................................
  def other_tags_count
    count = other_tags.count
    (count > 0) ? count : 1
  end

  def filter_other_tags
    other_tags.joins(:exam_exercises)
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
