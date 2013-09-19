
def f(n)
  # define f so that f(f(n)) == -n
end

# -- Test "suite"

tests = {
   1    => -1,
   0.1  => -0.1,
  -0.01 =>  0.01,
   0    =>  0,
   nil  =>  nil,
}

check tests do |n|
  f(f(n))
end
