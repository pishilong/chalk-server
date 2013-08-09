# encoding: utf-8

# 题目
#
# @note **Base URI** `/tar/questions`
class Tar::QuestionsController < Tar::BaseController

  # 加载题目
  #
  # @param [String] :id 题目 ID
  #
  # @note **API** `GET /:id [html]`
  def show
    @exam_paper = {
      year: 2012,
      province_text: '北京市',
      arts_science_text: '文科'
    }

    @question = {
      number: 3
    }
  end

  # 更新题目, 包括是否启用选项解析等
  #
  # @param [String] :id 题目 ID
  #
  # @param [Hash] :question 要更新的题目数据
  # @param [Hash] :question[:question_content] 要更新的题目内容数据
  #
  # @note **API** `PUT /:id [json]`
  def update
  end

end
