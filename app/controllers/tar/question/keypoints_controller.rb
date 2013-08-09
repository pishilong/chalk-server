# encoding: utf-8

# 考察点 (与题目的关联)
#
# @note **Base URL** `/tar/questions/:question_id/keypoints`
class Tar::Question::KeypointsController < Tar::BaseController

  # 关联考察点
  #
  # @note **API** `PUT /:id [json]`
  #
  # @param [String] :id
  # @param [String] :option 此关联针对的选项, 如 "A", "D" 等;
  #   仅用于选择题; 可以是空 (模式一)
  def update
  end

  # 删除考察点关联
  #
  # @note **API** `DELETE /:id [json]`
  #
  # @param [String] :id
  #
  # @return `{}`
  def destroy
  end

end
