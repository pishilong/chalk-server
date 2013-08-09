# encoding: utf-8

# 标签 (与题目的关联)
#
# @note **Base URL** `/tar/questions/:question_id/tags`
class Tar::Question::TagsController < Tar::BaseController

  # 创建标签并关联到题目
  #
  # @note **API** `POST / [json]`
  #
  # @param [String] :new_tag_type 是否新建标签类型, 取值 'true' / 'false',
  #   为 'true' 时表示同时创建新的标签类型
  # @param [String] :parent_id 父标签类型的 ID, 仅用于 `new_tag_type` 为
  #   'true' 时, 可以为空
  # @param [String] :question_tag_type_name 标签类型名称, 仅用于
  #   `new_tag_type` 为 'true' 时
  #
  # @param [String] :question_tag_type_id 关联到的标签类型的 ID, 仅用于
  #   `new_tag_type` 为 'false' 或空时
  #
  # @param [String]: name 标签名称
  # @param [String]: content 标签内容
  def create
  end

  # 关联标签
  #
  # @note **API** `PUT /:id [json]`
  def update
  end

  # 删除标签关联
  #
  # @note **API** `DELETE /:id [json]`
  def destroy
  end

end
