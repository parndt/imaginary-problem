require './micro_test'

def f(n)
  case n
  when Numeric then Proc.new { n * -1 }
  when Proc    then n.call
  end
end

# -- Test "suite"

test = MicroTest.new { |n| f(f(n)) }
test.check(
   1    => -1,
   0.1  => -0.1,
  -0.01 =>  0.01,
   0    =>  0,
   nil  =>  nil,
   10   => -1,    # FAIL
)
