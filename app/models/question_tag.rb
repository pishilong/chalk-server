class QuestionTag < ActiveRecord::Base
  belongs_to :parent, :class_name => 'QuestionTag'
  belongs_to :question_tag_type
end
