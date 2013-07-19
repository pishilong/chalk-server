# encoding: utf-8

module OrderIdx
  extend ActiveSupport::Concern

  included do
    before_create :init_order_idx
    before_update :set_order_idx_for_update, if: :order_idx_changed?
    before_destroy :set_order_idx_for_destroy
  end

  module ClassMethods
    def order_idx_scope(scope)
      scope = [scope] unless Array === scope
      self.class_variable_set(:@@order_idx_scope, scope)
    end

    def arrange_order_idx(obj, exclude_self = false, for_update = false)
      logger.debug(:arrange_order_idx) do
        "exclude_self: #{exclude_self}, for_update: #{for_update}"
      end
      q = obj.order_idx_relation.select("id, order_idx").reorder("order_idx ASC")
      q = q.where("id != ?", obj.id) if exclude_self
      idx = 1
      self.transaction do
        q.each do |current_obj|
          idx += 1 if for_update && idx == obj.order_idx
          current_obj.update_column(:order_idx, idx) if current_obj.order_idx != idx
          idx += 1
        end
      end
    end
  end

  def order_idx_query
    scope = self.class.class_variable_get(:@@order_idx_scope)

    query = {}
    scope.each do |attr|
      query[attr.to_sym] = self.send(attr.to_sym)
    end

    query
  end

  def order_idx_relation
    self.class.where(order_idx_query)
  end

  def rearrange_order_idx(options = {})
    options = {exclude_self: false, for_update: false}.merge(options)
    self.class.arrange_order_idx(self, options[:exclude_self], options[:for_update])
  end

  def first_by_order_idx
    order_idx_relation.reorder("order_idx ASC").first
  end

  def next_by_order_idx
    if self.id
      order_idx_relation.reorder("order_idx ASC").
        where("id != ? AND order_idx > ?", self.id, self.order_idx).first
    else
      nil
    end
  end

  private

  def init_order_idx
    max = order_idx_relation.maximum(:order_idx)
    self.order_idx = (max || 0) + 1
  end

  def set_order_idx_for_update
    self.class.arrange_order_idx(self, true, true)
  end

  def set_order_idx_for_destroy
    self.class.arrange_order_idx(self, true, false)
  end
end
