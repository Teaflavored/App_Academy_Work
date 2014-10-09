# Always try to make everything into a method so you can reuse it
# Always move the unimportant implementation details into a private method inside class
# Tell, don't ask -> don't ask/modify internal states of the object
# Don't let internal details of a class leak into something else
# use messages between classes
#
# make sure that methods are short, concise,
# make sure methods dont' take too many arguments so arguments won't get coupled
# if group of data is always being passed around together, you can extract them into an object
# try to use as few dots as possible, don't chain many methods together
#
#
# solve concrete problem, don't try to solve abstract problme
#
#
# scope is the context in which a variable name is valid and can be used,
# a new level starts whenever we start a class, a method, or a block
#
# can't use a variable before it's defined
#
# https://gist.github.com/1109c11b32b642ca71b1


# **Tip**: On school computers, run `option + command + c` to run Rubocop
# What is tap?
# What is <=>?
# proc shorthand
 
# require 'byebug'
# result = [1, 2, 3, 4].map do |a|
#   a + 3
# end.map do |b|
#   b * 2
# end.map do |c|
#   c.odd? ? (c * c) : (c * 2)
# end
# p result # => [16, 20, 24, 28]
 
# Code Smells
# +  Un-DRY code
# +  Long methods/methods with more than one responsibility
#    + Hard to test
# +  Methods w/ too many parameters
# +  Speculative Granularity: Follow the YAGNI principles
#    + Don't try to make code too general or to handle every possible situation
#    + Don't add new features until there's a definitive need for them
#    + Don't add new features until you understand the problem to solve
# +  Dead/Lava code
# +  Public methods that should be private
#    + Have the smallest public interface possible
#    + Strive for loose coupling
#    + You don't want others using methods you might want to change
# +  God Objects
# +  Strive for Clean Code
# +  Code smell indicates a need for refactoring
# +  LoD (long method chains is the smell, talking to non neighbors is the issue)
#    + Don't call `some_object.some_attribute.some_attribute` from another class
#    + Instead, make a method on that class that exposes it
#    + Don't want one class to rely on the internal structure of another class,
#      as it might change
         # You can play with yourself.
         # You can play with your own toys (but you can’t take them apart),
         # You can play with toys that were given to you.
         # And you can play with toys you’ve made yourself.
 
 
 
# arrays = Array.new(3, [])
# arrays.first << 1
# p arrays
#
# arrays = Array.new(3) { [] }
# arrays.first << 1
# p arrays
 
powers = Hash.new([])
powers["superman"] << 'Faster than a speeding bullet'
powers["superman"] << 'More powerful than a locomotive'
powers["superman"] << 'Able to leap tall buildings in a single bound'
powers["superman"] # => ["Faster than a speeding bullet", "More powerful than a locomotive", "Able to leap tall buildings in a single bound"]
 
# powers["ironman"] << 'Wealth'
# string = 'Ruby is sweet'
# indexes = Hash.new([])
#(0...string.length).each { |index| indexes[string[index]] << index }
 
# # Count up the frequency of each character
# counts = Hash.new(0)
# string = 'Ruby is sweet'
# (0...string.length).each { |index| counts[string[index]] += 1 }
# Is the same as: counts[string[index]] = counts[string[index]].+(1)
#
# is it 10? BONUS!
# auth = {
#   'info' => {
#     'email'      => 'olaf@frozen.com',
#     'last_name'  => 'of Arendale'
#   },
#   'credentials' => {
#     'token' => "banana"
#   }
# }
# class User
#   attr_accessor :email_address, :first_name, :last_name, :token
# end
# u = User.new
# u.email_address = auth['info']['email']
# u.first_name    = auth['info']['first_name']
# u.last_name     = auth['info']['last_name']
# u.token         = auth['credentials']['token']
# greeting = "Good morning, #{u.first_name.capitalize}"
# greeting # =>
#
# or raise ArgumentError
 
 
# >> [16, 20, 24, 28]