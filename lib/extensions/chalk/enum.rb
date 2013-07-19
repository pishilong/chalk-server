class Chalk::Enum < ActiveSupport::HashWithIndifferentAccess
  attr_reader :options

  def initialize(items)
    items = Hash[items.map{|o| [o, o.to_s]}] if items.is_a?(Array)

    key_error_proc = Proc.new { |_h, _k| raise "Enum has no key: #{_k}. Valid keys: #{_h.keys}" }
    super(&key_error_proc)

    value_class = nil
    raise "Values in enum must be of the same type!" unless items.values.all? do |v|
      value_class ||= v.class
      v.nil? or v.class == value_class
    end

    if value_class == Hash
      @options = ActiveSupport::HashWithIndifferentAccess.new(&key_error_proc)
      final_items = {}
      items.each do |k, v_hash|
        @options[k] = ActiveSupport::HashWithIndifferentAccess.new(&key_error_proc)
        @options[k].update(v_hash)
        @options[k].freeze
        final_items[k] = v_hash.key?(:value) ? v_hash[:value] : k.to_s
      end
    else
      final_items = items
    end

    if final_items.values.size != final_items.values.uniq.size
      raise "Values in enum must be unique! #{final_items.values}"
    end

    self.update(final_items)
    self.freeze
  end

  def value(key1, key2 = nil, opts = nil)
    raise "No arguments is given!" if key1.nil?
    if opts.nil? && Hash === key2
      opts = key2
      key2 = nil
    end
    opts = {value: false}.merge(opts || {})
    if opts[:value]
      raise "Enum has no value: #{key1}. Valid values: #{values}" unless value?(key1)
      key1 = key(key1)
    end
    key2.nil? ? self[key1] : @options[key1][key2]
  end

  def check(text)
    raise "Enum has no text: #{text}. Valid keys: #{self.keys}" unless self.key?(text)
    text
  end

  def to_collection(_options = {})
    options = {label: nil}.merge(_options)
    return self if options[:label].nil?
    collection = {}
    self.each do |k, v|
      collection[self.value(k, options[:label])] = v
    end
    collection
  end

  def value_of?(value, key)
    options[key].values.include? value
  end
end
