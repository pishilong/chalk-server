class TopicExtension < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................
  #include ActiveModel::ForbiddenAttributesProtection
  #include TarActivity

  # security (i.e. attr_accessible) ...........................................
  attr_accessible :study_resorce_category_id, :material, :material_reader_count,
    :comments_count, :average_score

  # relationships .............................................................
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