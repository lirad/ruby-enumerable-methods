# rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
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
    return false if obj.nil? && !block_given?
    result = true
    
    if obj.nil?
      my_each { |i| return !result unless yield(i) }
    elsif obj.is_a? String
      my_each { |i| return !result unless i.match?(obj) }
    elsif obj.is_a? Integer
      my_each { |i| return !result unless i == obj }
    end
    result
  end

  def my_any?(obj = nil)
    return false if obj.nil? && !block_given?

    result = true
    if obj.nil?
      my_each { |i| break result unless yield(i) }
    elsif !obj.nil?
      my_each { |i| break result unless i.match?(obj) }
    end
    result
  end

  def my_none?(obj = nil)
    return if false obj.nil? && !block_given?

    result = true
    if obj.nil?
      my_each { |i| break result = unless yield(i) }
    elsif !obj.nil?
      my_each { |i| break result = unless i.match?(obj) }
    end
    result
  end

  def my_count(obj = nil)
    counter = 0
    if obj.nil? && !block_given?
      my_each { |i| counter += 1 }
    elsif block_given?
      my_each { |i| counter += 1 if yield(i) }
    end
    return counter
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
    

    def my_inject(start = self[0])
      raise('LocalJumpError') if !block_given? && obj.nil?
      self.my_each { |i|
          start = yield(start, i)
      }
      start
  end
end

puts [2,4,5].my_inject(0) {|t, i| t + i}

def multiply_els(arr)
  arr.my_inject(:*)
end
# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
