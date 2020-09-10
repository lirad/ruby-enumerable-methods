require './enumerable.rb'

describe Enumerable do

  let(:array_integers) {(0..10).to_a}
  let(:array_strings) {%w[John Mary Douglas Michael]}
  let(:hash) {[{"Michael" => 2}, {"John" => 3}]}
  let(:result) {[]}
  let(:compare) {[]}

  describe "#my_each" do
   
    it "Return every element of an array of integers passing a block" do
      array_integers.my_each { |n| result << n + 1}
      array_integers.each { |n| compare << n + 1}
      expect(result).to eq(compare)
    end

    it "Return every element of an array of strings" do
      array_strings.my_each { |n| result << n }
      array_strings.each { |n| compare << n  }
      expect(result).to eq(compare)
    end

    it "Return every element of a Hash" do
      hash.my_each { |n| result << n}
      hash.each { |n| compare << n}
      expect(result).to eq(compare)
    end
  end

  describe "#my_each_with_index" do
   
    it "Return every element of an array of integers passing a block" do
      array_integers.my_each_with_index { |n| result << n + 1}
      array_integers.each_with_index { |n| compare << n + 1}
      expect(result).to eq(compare)
    end

    it "Return every element of an array of strings" do
      array_strings.my_each_with_index { |n| result << n }
      array_strings.each_with_index { |n| compare << n  }
      expect(result).to eq(compare)
    end

    it "Return every element of a Hash" do
      hash.my_each_with_index { |key, value| result << value + 2}
      hash.each_with_index { |key, value| compare << value + 2}
      expect(result).to eq(compare)
    end
  end

  describe "#my_select" do
   
    it "Checks if a element is selected from array" do
      result = array_integers.my_select { |n| n > 9 }  
      compare = array_integers.select { |n| n > 9 }  
      expect(result).to eq(compare)
    end

    it "Checks if a element is selected from array of strings" do
      result = array_strings.my_select { |n| n == 'John'}
      compare = array_strings.select { |n| n == 'John'}
      expect(result).to eq(compare)
    end

    it "Checks if a element is selected from a hash" do
      result = hash.my_select { |n|  n['John'] }
      compare = hash.select { |n|  n['John']}
      expect(result).to eq(compare)
    end
  end

  describe "#my-all?" do
    it "Checks for true if all elements matchs the condition" do
      result = array_strings.my_all?(array_strings)
      compare = array_strings.all?(array_strings)
      expect(result).to eq(compare)
    end
  end


end