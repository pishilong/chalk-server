class Knowledge < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................
  #include ActiveModel::ForbiddenAttributesProtection
  #include TarActivity

  # security (i.e. attr_accessible) ...........................................
  attr_accessible :exam_category_id, :title, :content

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
