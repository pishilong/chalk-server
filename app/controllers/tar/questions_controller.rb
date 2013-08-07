# encoding: utf-8

# 题目
# base URL: /tar/questions
class Tar::QuestionsController < ApplicationController

  # 加载题目
  # GET /:id
  # content-type: HTML
  def show
  end

  # 更新题目
  # PUT /:id
  # content-type: JSON
  # description: update question and/or the question's content
  def update
  end

  # 修改考察点关联模式
  # PUT /:id/keypoint_mode
  # parameters:
  #   option_mode: true / false
  def keypoint_mode
  end

end
