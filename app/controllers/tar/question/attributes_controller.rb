# encoding: utf-8

# "易错点" 等属性 (与题目的关联)
#
# @note **Base URL** `/tar/questions/:question_id/attributes`
class Tar::Question::AttributesController < Tar::BaseController

  # 关联属性并设置内容
  #
  # @note **API** `PUT /:id [json]`
  #
  # @param [String] :content 内容
  def update
  end

end
