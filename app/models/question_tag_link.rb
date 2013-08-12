class QuestionTagLink < ActiveRecord::Base
  belongs_to :question
  belongs_to :question_tag
end
