
def f(n)
  # define f so that f(f(n)) == -n
end

# -- Test "suite"

def check(values, &test)
  values.each do |input, expected|
    actual = test.call input
    if actual == expected
      puts "#{input.inspect} => #{actual.inspect}"
    else
      puts "Expected #{input.inspect} => #{expected.inspect}: got #{actual.inspect}"
    end
  end
end

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
