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
      yield(self.to_a[index], index)
    end
    
    self
  end  

end