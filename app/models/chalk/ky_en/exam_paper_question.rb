# encoding: utf-8

class Chalk::KyEn::ExamPaperQuestion < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................
  #include ActiveModel::ForbiddenAttributesProtection
  #include TarActivity
  # security (i.e. attr_accessible) ...........................................

  # relationships .............................................................
  belongs_to :exam_paper, class_name: "Chalk::KyEn::ExamPaper"
  belongs_to :exam_paper_structure, class_name: "Chalk::KyEn::ExamPaperStructure"
  belongs_to :exam_paper_exercise, class_name: "Chalk::KyEn::ExamPaperExercise"

  # constants definition ......................................................
  PROCESS_STATUS = Chalk::Enum.new({
    '未处理' => 0,
    '一轮处理完毕' => 20,
    '二轮处理完毕' => 40,
  })

  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................

  # additional config .........................................................
  establish_connection :chalk_production

  # class methods .............................................................

  # public instance methods ...................................................
  def process_status_str
    process_status ? PROCESS_STATUS.key(process_status) : nil
  end

  def answer_type
    question_type
  end

  def difficulty
    nil
  end

  def fallible_point
    nil
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
