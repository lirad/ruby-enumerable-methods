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
end



