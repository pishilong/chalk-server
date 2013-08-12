class QuestionAttributeLink < ActiveRecord::Base
  belongs_to :question
  belongs_to :question_attribute
end
