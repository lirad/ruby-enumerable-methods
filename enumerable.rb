# rubocop:disable Metrics/MethodLength
module Enumerable
  def my_each(_array = nil)
    return to_enum unless block_given?

    Array(self).length.times do |i|
      yield(Array(self)[i])
    end
    self
  end

  def my_each_with_index(_array = nil)
    return to_enum unless block_given?

    Array(self).length.times do |index|
      yield(to_a[index], index)
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    result = []
    my_each do |item|
      result.push(item) if yield(item)
    end
    result
  end

  def my_all?(obj = nil)
    return true if obj.nil? && !block_given?

    result = true
    if obj.nil?
      my_each { |i| return !result unless yield(i) }
    elsif !obj.nil?
      my_each { |i| return !result unless i.match?(obj) }
    end
    result
  end

  def my_any?(obj = nil)
    return true if obj.nil? && !block_given?

    result = false
    if obj.nil?
      my_each { |i| break result = true if yield(i) }
    elsif !obj.nil?
      my_each { |i| break result = true if i.match?(obj) }
    end
    result
  end

  def my_none?(obj = nil)
    return true if obj.nil? && !block_given?

    result = true
    if obj.nil?
      my_each { |i| break result = false if yield(i) }
    elsif !obj.nil?
      my_each { |i| break result = false if i.match?(obj) }
    end
    result
  end

  def my_count(obj = nil)
    counter = 0
    if obj.nil? && !block_given?
      my_each { |_i| counter += 1 }
    elsif block_given?
      my_each { |i| counter += 1 if yield(i) }
    end

    counter
  end

  def my_map(_array = nil)
    return to_enum unless block_given?

    new_array = []
    my_each do |i|
      new_array.push(yield(i))
    end
    new_array
  end

  def my_inject(obj = nil)
    raise('Block or argument missing!') if !block_given? && obj.nil?

    if obj.nil?
      n = length - 1
      accumlator = yield(self[0])
      n.times do |i|
        accumlator = if i.zero?
                       yield(self[0])
                     else
                       yield(accumlator)
                     end
      end
    else
      accumlator = 1
      my_each_with_index do |item, _index|
        accumlator = accumlator.send(obj[0], item)
      end
    end
    accumlator
  end
end

def multiply_els(arr)
  arr.my_inject(:*)
end
# rubocop:enable,Metrics/MethodLength
