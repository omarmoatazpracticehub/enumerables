module Enumerable
	def my_each
		i = 0
		while i < self.length
			yield(self[i])
			i += 1
		end
		return self
	end
	def my_each_with_index
		i = 0
		while i <= self.length - 1
			yield self[i], i
			i += 1
		end

	end
	def my_select
		return self.to_enum if !block_given?
		ret_arr = Array.new
		self.each do |element|
			if yield(element) == true
				ret_arr << element
			end
		end
		return ret_arr
	end
	def my_all?
		match_all = true
		self.my_each do |x|
			if !yield(x)
				match_all = false
				break
			end
		end
		return match_all
	end
	def my_any?
		match_any = false
		self.my_each do |x|
			if yield(x)
				match_any = true
				break
			end
		end
		return match_any
	end
	def my_none?
		match_count = 0
		self.my_each do |x|
			if yield(x)
				match_count += 1
			end
		end
		return true if match_count == 0
		return false
	end
	def my_count(*params)
		if !block_given?
			if params.length == 0
				return self.length
			else
				count_match = 0
				self.my_each do |x|
					count_match += 1 if x == params[0]
				end
				return count_match
			end
		else
			count = 0
			self.my_each do |x|
				count += 1 if yield(x)
			end
			return count
		end
	end
	def my_map
		return self.to_enum if !block_given?
		new_array = []
		self.my_each do |x|
			new_array << yield(x)
		end
		return new_array
	end 
	def my_inject(accumulator = nil)
		accumulator = self[0] if accumulator == nil
		self.my_each_with_index do |current, index|
			accumulator = yield(accumulator, current) if index != 0
		end
		return accumulator
	end
end

array = [4,5,2,2,8]
# array.my_each {|x| puts x + 1}
# [].my_each {}
# puts array.my_select {|x| x > 2}.inspect
# puts arr.inspect 
# puts array.my_each {|x| x += 1}
puts (array.my_inject(1) {|sum, number| sum + number})