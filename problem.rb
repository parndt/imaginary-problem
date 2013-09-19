
def f(n)
  # define f so that f(f(n)) == -n
end

# -- Test "suite"

ANSI_GREEN = 32
ANSI_RED   = 31

def check(values, &test)
  values.each do |input, expected|
    actual = test.call input
    if actual == expected
      puts_color ANSI_GREEN, "#{input.inspect} => #{actual.inspect}"
    else
      puts_color ANSI_RED, "Expected #{input.inspect} => #{expected.inspect}: got #{actual.inspect}"
    end
  end
end

def puts_color(color_code, message)
  puts "\e[0;#{color_code}m" << message << "\e[0m"
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
