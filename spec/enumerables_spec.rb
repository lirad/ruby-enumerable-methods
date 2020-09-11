require './enumerable.rb'

describe Enumerable do
  let(:array_integers) { (1..10).to_a }
  let(:array_integers_false) { (1..9).to_a }
  let(:array_strings) { %w[John Mary Douglas Michael] }
  let(:array_strings_false) { %w[John Mary Douglas] }
  let(:array_reduced) { 3_628_800 }
  let(:true_array) { [1, true, 'hi', []] }
  let(:false_array) { [1, false, 'hi', []] }
  let(:hash) { [{ 'Michael' => 2 }, { 'John' => 3 }] }
  let(:result) { [] }
  let(:compare) { [] }

  describe '#my_each' do
    it 'Return every element of an array of integers passing a block' do
      array_integers.my_each { |n| result << n + 1 }
      array_integers.each { |n| compare << n + 1 }
      expect(result).to eq(compare)
    end

    it 'Return every element of an array of strings' do
      array_strings.my_each { |n| result << n }
      array_strings.each { |n| compare << n }
      expect(result).to eq(compare)
    end

    it 'Return every element of a Hash' do
      hash.my_each { |n| result << n }
      hash.each { |n| compare << n }
      expect(result).to eq(compare)
    end
  end

  describe '#my_each_with_index' do
    it 'Return every element of an array of integers passing a block' do
      array_integers.my_each_with_index { |n| result << n + 1 }
      array_integers.each { |n| compare << n + 1 }
      expect(result).to eq(compare)
    end

    it 'Return every element of an array of strings' do
      array_strings.my_each_with_index { |n| result << n }
      array_strings.each { |n| compare << n }
      expect(result).to eq(compare)
    end

    it 'Return every element of a Hash' do
      hash.my_each_with_index { |_key, value| result << value + 2 }
      hash.each_with_index { |_key, value| compare << value + 2 }
      expect(result).to eq(compare)
    end
  end

  describe '#my_select' do
    it 'Checks if a element is selected from array' do
      result = array_integers.my_select { |n| n > 9 }
      compare = [10]
      expect(result).to eq(compare)
    end

    it 'Checks if a element is selected from array of strings' do
      result = array_strings.my_select { |n| n == 'John' }
      compare = ['John']
      expect(result).to eq(compare)
    end

    it 'Checks if a element is selected from a hash' do
      result = hash.my_select { |n| n['John'] }
      compare = hash.select { |n| n['John'] }
      expect(result).to eq(compare)
    end
  end

  describe '#my_all?' do
    it 'Checks for true if all elements in a integer array matchs all the conditions' do
      result = array_integers.my_all?(array_integers.all?)
      expect(result).to eq(true)
    end

    it 'Checks for false if all elements in a integer arrays matchs all the conditions' do
      result = array_integers.my_all?(array_integers_false)
      expect(result).to eq(false)
    end

    it 'Checks for true if all elements string arrays matchs all the conditions' do
      result = array_strings.my_all?(array_strings.all?)
      expect(result).to eq(true)
    end

    it 'Checks for false if all the string arrays conditions are not met' do
      result = array_strings.my_all?(array_strings_false)
      expect(result).to eq(false)
    end

    it 'Checks for regex for true' do
      expect(['diego'].my_all?(/diego/)).to eq(true)
    end

    it 'Checks for regex for false' do
      expect(['diego'].my_all?(/diegodiego/)).to eq(false)
    end

    it 'Checks true if no blocks or argument is given and at least one element is true' do
      expect(true_array.my_all?).to eq(true)
    end

    it 'Checks false if no blocks or argument is given and at least one element is false' do
      expect(false_array.my_all?).to eq(false)
    end
  end

  describe '#my_any?' do
    it 'Checks for true if any elements in a integer array exists' do
      result = array_integers.my_any?(1)
      expect(result).to eq(true)
    end

    it 'Checks for false none of elements exists in a integer array' do
      result = array_integers.my_any?(11)
      expect(result).to eq(false)
    end

    it 'Checks for true if any elements in a string of arrays matchs any of the conditions' do
      result = array_strings.my_any?('John')
      compare = array_strings.any?('John')
      expect(result).to eq(compare)
    end

    it 'Checks for false if none of the elements in string array matchs all the conditions' do
      result = array_strings.my_any?('Pedro')
      compare = array_strings.any?('Pedro')
      expect(result).to eq(compare)
    end

    it 'Checks true if no blocks or argument is given and at least one element is true' do
      expect(true_array.my_any?).to eq(true)
    end

    it 'Checks false if no blocks or argument is given and at least one element is false' do
      expect(false_array.my_any?).to eq(false)
    end

    it 'Checks regex for true' do
      expect(['diego'].my_any?(/di/)).to eq(true)
    end

    it 'Checks regex for false' do
      expect(['diego'].my_any?(/li/)).to eq(false)
    end
  end

  describe '#my_none?' do
    it 'Checks for true if any elements in a integer array exists' do
      result = array_integers.my_none?(1)
      expect(result).to eq(false)
    end

    it 'Checks for false none of elements exists in a integer array' do
      result = array_integers.my_none?(11)
      expect(result).to eq(true)
    end

    it 'Checks if returns true if none of the conditions in strings array are met' do
      result = array_strings.my_none?('Pedro')
      expect(result).to eq(true)
    end

    it 'Checks if returns false if any of the conditions in strings array are met' do
      result = array_strings.my_none?('John')
      expect(result).to eq(false)
    end


    it 'Checks true if no blocks or argument is given and at least one element is true' do
      expect(true_array.my_none?).to eq(true)
    end

    it 'Checks false if no blocks or argument is given and at least one element is false' do
      expect(false_array.my_none?).to eq(false)
    end

    it 'Checks regex for true' do
      expect(['diego'].my_none?(/li/)).to eq(true)
    end

    it 'Checks regex for false' do
      expect(['diego'].my_none?(/di/)).to eq(false)
    end
  end

  describe '#my_count' do
    it 'Check if number of elements is equal to the passed object' do
      result = array_integers.my_count
      compare = array_integers.length
      expect(result).to eq(compare)
    end

    it 'Check if number of elements is equal to the passed conditon' do
      result = array_strings.my_count { |n| n == 'John' }
      compare = 1
      expect(result).to eq(compare)
    end
  end

  describe '#my_map' do
    proc = proc { |element| element }
    it 'Check if my map modifies the passed array' do
      result = array_integers.map { |n| n * 2 }
      expect(array_integers).not_to eq(result)
    end

    it 'Check if my_map work with procs' do
      expect(array_integers.my_map(&proc)).to eql(array_integers)
    end
  end

  describe '#my_inject' do
    proc = proc { |n, g| n * g }

    it 'Check if it works with a block ' do
      expect(array_integers.my_inject { |n, g| n * g }).to eql(array_reduced)
    end
    it 'Check if works with an argument' do
      expect(array_integers.my_inject(:*)).to eql(array_reduced)
    end
    it 'Check if it works with a proc' do
      expect(array_integers.my_inject(&proc)).to eql(array_reduced)
    end
  end
end

describe Multiply do
  let(:multiply) { Multiply.new }
  let(:array_integers) { (1..10).to_a }
  let(:array_reduced) { 3_628_800 }
  describe '#multiply_els' do
    it 'Check if returns the product of each element multiplied' do
      expect(multiply.multiply_els(array_integers)).to eql(array_reduced)
    end
  end
end
