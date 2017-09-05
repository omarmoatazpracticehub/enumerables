# module Enumerable
# 	def initialize(arr)
# 		self = arr
# 	end
# 	def my_each
# 		i = 0
# 		while i <= array.length - 1
# 			yield(@arr[i], i)
# 			i += 1
# 		end
# 	end
# 	def my_each_with_index
# 		i = 0
# 		while i <= array.length - 1
# 			yield @arr[i], i
# 			i += 1
# 		end
# 	end
# 	def my_select
# 		@arr.my_each do |x|
# 			yield x
# 		end
# 	end
# 	def my_all?
# 		@arr.each {|x| yield(x)}
# 	end
# 	def my_any?
# 		found = false
# 		@arr.my_each do |x|
# 			yield(x)
# 		end
# 	end
# end

module Enumerable
	def my_each
	i = 0
	while i <= self.length - 1
		yield(self[i])
		i += 1
	end
	end
	def my_each_with_index
		i = 0
		while i <= self.length - 1
			yield self[i], i
			i += 1
		end
	end
	def my_select
		self.my_each {|element| yield element}
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
end

array = [4,5,2,2,8]
# or (these are both valid ways to create new array objects)
# array.my_each { |element| puts element }
# array.my_each_with_index {|element, index| print "#{element}'s index is #{index}\n"}
# array.my_select {|x| puts x if x.to_s =~ /[123]/}
#puts (array.my_count{|x| x % 2 ==0})
puts array.my_none? {|x| x <= 1}