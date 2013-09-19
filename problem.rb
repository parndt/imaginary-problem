require './micro_test'

def f(n)
  # Solving imaginary problems from scratch in Ruby! /pun
  n * Complex::I if n
end

# -- Test "suite"

test = MicroTest.new { |n| f(f(n)) }
test.check(
   1    => -1,
   0.1  => -0.1,
  -0.01 =>  0.01,
   0    =>  0,
   nil  =>  nil,
)
