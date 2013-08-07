# encoding: utf-8

# 考察点 (与题目的关联)
# base URL: /tar/questions/:question_id/keypoints
class Tar::Question::KeypointsController < ApplicationController

  # 关联考察点
  # PUT /:id
  # parameters:
  #   option: 此关联针对的选项, 如 "A", "D" 等; 仅用于选择题; 可以是空 (模式一)
  def update
  end

  # 删除考察点关联
  # DELETE /:id
  def destroy
  end

end
