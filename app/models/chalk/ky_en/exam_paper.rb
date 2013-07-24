# encoding: utf-8

class Chalk::KyEn::ExamPaper < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................
  #include ActiveModel::ForbiddenAttributesProtection
  #include TarActivity
  # security (i.e. attr_accessible) ...........................................

  # relationships .............................................................
  has_many :exam_paper_structures, class_name: "Chalk::KyEn::ExamPaperStructure"
  has_many :exam_paper_exercises, class_name: "Chalk::KyEn::ExamPaperExercise"
  has_many :exam_paper_questions, class_name: "Chalk::KyEn::ExamPaperQuestion"

  # constants definition ......................................................
  TYPE = Chalk::Enum.new(
    '全国大学英语四级考试' => 1,
    '全国大学英语六级考试' => 2,
    '全国硕士研究生入学考试' => 3,
  )

  SOURCE = Chalk::Enum.new(
    '真题' => 0,
    '模拟题' => 1,
    '辅导书' => 2,
    '竞赛题' => 3,
    '其他' => 4,
  )

  STATUS = Chalk::Enum.new({
    '未处理' => 0,
    '处理中' => 10,
    '已处理' => 20,
    '未复核' => 30,
    '复核中' => 40,
    '已复核' => 50,
    '已确认' => 60,
    '已禁用' => 70
  })

  PROCESS_STATUS = Chalk::Enum.new({
    '未处理' => 0,
    '已核对' => 10,
    '已确认' => 20,
    '已禁用' => 30,
    '一轮处理中' => 40,
    '一轮处理完毕' => 50,
    '二轮处理中' => 60,
    '二轮处理完毕' => 70
  })

  REGION_TYPE = Chalk::Enum.new(
    '全国' => '全国',
    '地方' => '地方'
  )

  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................

  # additional config .........................................................
  establish_connection :chalk_production

  # class methods .............................................................

  # public instance methods ...................................................
  def child_exam_paper_structures
    exam_paper_structures.where(level: 1).order("order_index ASC")
  end

  def exam_category
    ExamCategory.where(exam_type: ExamCategory::EXAM_TYPE['考研'],
      subject: ExamCategory::SUBJECT['英语']).first
  end

  def status_str
    status ? STATUS.key(status) : nil
  end

  def process_status_str
    process_status ? PROCESS_STATUS.key(process_status) : nil
  end

  def source_str
    source ? SOURCE.key(source) : nil
  end

  def region_type_str
    if region_type
      REGION_TYPE.key(region_type)
    else
      (province_id.nil? && city_id.nil? && district_id.nil?) ? '全国' : '地方'
    end
  end

  def forbidden?
    status == STATUS['已禁用'] || process_status == PROCESS_STATUS['已禁用']
  end

  # protected instance methods ................................................
  # private instance methods ..................................................
end
