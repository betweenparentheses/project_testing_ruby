module Enumerable
	def my_each
		return self unless block_given?
		counter = 0
		while counter < self.size
			yield(self[counter])
			counter += 1
		end
		self
	end

	def my_each_with_index
		return self unless block_given?
		counter = 0
		while counter < self.size
			yield(self[counter], counter)
			counter += 1
		end
		self
	end

	def my_select
		return self unless block_given?
		new_array = []
		self.my_each do |x|
			new_array << x if yield(x) == true
		end
		new_array
	end

	def my_all?
		all_true = true
		self.my_each do |x|
			if block_given?
				all_true = false if yield(x) == false
			else
				all_true = false if x == false
			end
		end
		all_true
	end

	def my_any?
		any_true = false
		self.my_each do |x|
			if block_given?
				any_true = true if yield(x) == true
			else
				any_true = true if x == true
			end
		end
		any_true
	end

	def my_none?
		none_true = true
		self.my_each do |x|
			if block_given?
				none_true = false if yield(x) == true
			else
				none_true = false if x == true
			end
		end
		none_true
	end

	def my_count (value = nil)
		count = 0
		if value
			self.my_each {|x| count += 1 if x == value}
			return count
		elsif block_given?
			self.my_each {|x| count +=1 if yield(x) == true}
			return count
		else
			return self.size
		end
	end

	def my_map(proc = nil)
		unless proc
			self.my_each_with_index do |x, index|
				self[index] = yield(x)
			end
		else
			self.my_each_with_index do |x, index|
				self[index] = proc.call(x)
				self[index] = yield(self[index]) if block_given?
			end
		end
		self
	end

	def my_inject (initial = self.first)
		return self unless block_given?
		accumulator = initial
		self.my_each do |x|
			accumulator = yield(accumulator, x)
		end
		accumulator
	end
end

def multiply_els(array)
	array.my_inject (1) {|running_multiple, element| running_multiple * element}
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
