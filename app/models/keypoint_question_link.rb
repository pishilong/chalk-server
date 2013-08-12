class KeypointQuestionLink < ActiveRecord::Base
  belongs_to :question
  belongs_to :keypoint
end
