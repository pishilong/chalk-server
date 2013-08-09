class Chalk::GzMath::ExamPapersSectionsExercise < Chalk::Base
  belongs_to :exam_paper, class_name: 'GzMath::ExamPaper'
  belongs_to :exam_section, class_name: 'GzMath::ExamSection'
  belongs_to :exam_exercise, class_name: 'GzMath::ExamExercise'
  
  has_many :keypoints_exercises, class_name: 'GzMath::KeypointsExercise'
  has_many :keypoints, through: :keypoints_exercises 
end
