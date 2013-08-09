# encoding: utf-8

class Tar::ExamPapersController < Tar::BaseController
  # 试卷处理
  def processing
    @exam_papers = [
      {
        year: '2012', province_text: '北京市', arts_science_text: '文科',
        choice_questions: [
          {number: 1}, {number: 2}, {number: 3}, {number: 4}, {number: 5},
          {number: 6}, {number: 7}, {number: 8}, {number: 9}, {number: 10}
        ],
        filling_questions: [],
        answering_questions: []
      }, {
        year: '2012', province_text: '河北省', arts_science_text: '理科',
        choice_questions: [],
        filling_questions: [{number: 14}, {number: 15}, {number: 16}],
        answering_questions: nil
      }
    ]
    # TODO
    # @exam_papers = ExamPaper.sorted(params[:sort], 'id ASC')
  end
end
