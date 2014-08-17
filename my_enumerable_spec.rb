require './my_enumerable.rb'

describe 'Enumerable' do
  before(:all) {@array = [1,2,3,4,5]}

  describe '#my_each' do

    context "when no block is given" do

      it "returns the input" do
        expect(@array.my_each).to eql([1,2,3,4,5])
      end

      it "works for empty arrays" do
        expect([].my_each).to eql([])
      end

    end

    context "when a block is given" do

      it "yields for each element" do
        expect { |b| @array.my_each(&b) }.to yield_successive_args(1,2,3,4,5)
      end

      it "properly performs the block" do
        b = []
        @array.my_each {|element| b << element + 1}
        expect(b).to eql([2,3,4,5,6])
      end
    end

  end

  describe '#my_each_with_index' do

    context "when no block is given" do

      it "returns the input" do
        expect(@array.my_each_with_index).to eql([1,2,3,4,5])
      end

      it "works for empty arrays" do
        expect([].my_each_with_index).to eql([])
      end

    end

    context "when a block is given" do

      it "yields for each element" do
        expect { |b| @array.my_each_with_index(&b) }.to yield_successive_args([1,0],[2,1],[3,2],[4,3],[5,4])
      end

      it "properly performs the block" do
        b = []
        @array.my_each_with_index { |element, index| b << element + 1}
        expect(b).to eql([2,3,4,5,6])
      end

      it "provides an index with each iteration" do
        indices = []
        @array.my_each_with_index { |element, index| indices << index }
        expect(indices).to eql([0,1,2,3,4])
      end

    end
  end

  describe '#my_select' do
    it "returns elements filtered by a boolean" do
      expect(@array.my_select{|x| x > 2}).to eql([3,4,5])
    end

  end

  describe '#my_all' do

  end

  describe '#my_inject' do

  end

  describe '#my_count' do

  end
end
#Many test runs follow below


#[1,2,3,4,5].my_each {|x| puts x}
#["A","B","C","D","E"].my_each_with_index {|x, index| puts "#{x}, #{index}"}
#puts [1,2,3,4,5].my_select {|x| x < 4}
#p [1,2,3,4,5].my_all? {|x| x > 0}
#p [1,2,3,4,5].my_all? {|x| x > 1}
#p [1,2,3,4,5].my_any? {|x| x > 5}
#p [1,2,3,4,5].my_inject {|running_total, x| running_total + x}
#p multiply_els([20,2,-3])


#p [1,2,3,4,5].my_count
#p [1,2,3,4,5].my_count(3)
#p [1,2,3,4,5].my_count {|x| x > 2}


#test = Proc.new{|z| z ** 3}
#puts [1,2,3,4,5].my_map(test) {|y| y * 2}
#puts [1,2,3,4,5].my_map(test)
#puts [1,2,3,4,5].my_map {|y| y*2}

#puts [false, false, true, false].my_all?
