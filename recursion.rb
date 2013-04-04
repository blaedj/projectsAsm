# f(0) = 0
# f(n) = 3*f(n-1) + 1, if n < o
n = 0
while n >= 0
  puts "Enter a value for 'n' :"
  n = gets.to_i
  if n < 0
    puts "goodbye!"
    exit!
  end

  def function_of_n(n)
    return 0 if n.zero?
    return 3*function_of_n(n-1) + 1
  end

  fn = function_of_n(n) # call the function that calculates n

  puts fn
end
