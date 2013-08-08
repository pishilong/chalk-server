# encoding: utf-8

# 标签 (与题目的关联)
# base URL: /tar/questions/:question_id/tags
class Tar::Question::TagsController < ApplicationController

  # 创建标签并关联到题目
  # POST /
  # parameters:
  #   new_tag_type: true / false, 为 true 时表示同时创建新的标签类型
  #   parent_id: 仅用于 new_tag_type 为 true 时, 可以为空
  #   question_tag_type_name: 仅用于 new_tag_type 为 true 时
  #   question_tag_type_id: 仅用于 new_tag_type 为 false 或空时
  #   name
  #   content
  def create
  end

  # 关联标签
  # PUT /:id
  def update
  end

  # 删除标签关联
  # DELETE /:id
  def destroy
  end

end
