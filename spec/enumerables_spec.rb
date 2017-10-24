require_relative '../lib/enumerables.rb'

class Dummy
	include Enumerable
end


describe Dummy do
	describe '.my_each' do
		context "given an empty array" do 
			it "returns an empty array" do
				expect([].my_each {|x| x += 1}).to eql([])
			end
		end
	end

	describe '.my_select' do 
		context "given an empty array" do 
			it "returns an empty array" do 
				expect([].my_select {|x| x > 1}).to eql([])
			end
		end

		context "given that some elements meet condition" do
			it "returns correct elements" do
				expect([1,6,7,4,5].my_select{|x| x > 5}).to eql([6,7])
			end
		end

		context "given that NO elements meet condition" do
			it "returns an empty array" do
				expect([1,2,3,4].my_select{|x| x > 5}).to eql([])
			end
		end

		context "given that ALL elements meet condition" do
			it "returns entire array" do
				expect([1,2,3,4].my_select{|x| x > 0}).to eql([1,2,3,4])
			end
		end

		context "given that NO block was given" do
			it "returns enumerator" do
				expect([1,2,3,4].my_select).to be_instance_of(Enumerator)
			end
		end
	end

	describe '.my_map' do
		context "given an empty array" do 
			it "returns an empty array" do 
				expect([].my_map {|x| x > 1}).to eql([])
			end
		end

		context "given multiplication operations" do
			it "returns result of op on every element" do
				expect([1,2,3].my_map {|x| x *= 2}).to eql([2, 4, 6])
			end
		end

		context "given that NO block was given" do
			it "returns Enumerator" do
				expect([1,2,3,4].my_map).to be_instance_of(Enumerator)
			end
		end
	end

	describe '.my_inject' do
		context "given an empty array" do
			it "returns an empty array" do
				expect([].my_inject{|sum, element| sum + element}).to eql(nil)
			end
		end

		context "given an array with + operation" do 
			it "returns an accumulated sum" do
				expect([1,2,3,4].my_inject{|sum, element| sum + element}).to eql(10)
			end
		end

		context "given an array with * operation" do
			it "returns the result of multiplying all elements" do 
				expect([1,2,3,4].my_inject{|multiple, element| multiple * element}).to eql(24)
			end
		end
	end
end