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
        @array.my_each_with_index { |element, index| b << element + 1 }
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
      expect(@array.my_select{ |x| x > 2 }).to eql([3,4,5])
    end

    context "when boolean is always true" do
      before(:all) { @all_true = true }
      it "returns all elements" do
        expect(@array.my_select{ |x| @all_true }).to eql(@array)
      end
    end

    context "when boolean is always false" do
      before(:all) { @all_false = false }
      it "returns an empty array" do
        expect(@array.my_select { |x| @all_false }).to be_empty
      end
    end
  end

  describe '#my_all?' do

    context "when all elements match the boolean" do
      it "returns true" do
        expect(@array.my_all? {|x| x < 900 }).to eql(true)
      end
    end

    context "when no elements match the boolean" do
      it "returns false" do
        expect(@array.my_all? {|x| x > 900 }).to eql(false)
      end
    end

  end

  describe '#my_inject' do


  end

  describe '#my_count' do
    context "when a value is given and no block" do

      it "returns the number of times that value appears in the object" do
        expect(@array.my_count(3)).to eql(1)
      end

      it "returns 0 for a value not found" do
        expect(@array.my_count("Q")).to eql(0)
      end
    end

    context "when a block is given and no value" do

      it "returns the number of elements for which that block returns true" do
        count = @array.my_count{ |x| x > 3 }
        expect(count).to eql(2)
      end

    end

    context "when no block and no value are given" do

      it "returns the size" do
        expect(@array.my_count).to eql(@array.size)
      end

    end

    context "when both block and value are given" do

      it "uses the value and ignores the block" do
        count = @array.my_count(3) { |x| x > 0 }
        expect(count).to eql(1)
      end

    end

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
