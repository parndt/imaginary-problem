
def f(n)
  case n
  when Numeric then Proc.new { n * -1 }
  when Proc    then n.call
  end
end

# -- Test "suite"

ANSI_GREEN = 32
ANSI_RED   = 31

def check(values, &test)
  values.each do |input, expected|
    actual = test.call input
    if actual == expected
      @pass_count += 1
      puts_color ANSI_GREEN, "#{input.inspect} => #{actual.inspect}"
    else
      @fail_count += 1
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
   10   => -1,    # FAIL
}

@pass_count = 0
@fail_count = 0

check tests do |n|
  f(f(n))
end

puts '---'
puts_color ANSI_GREEN, "Passed: #{@pass_count}" if @pass_count > 0
puts_color ANSI_RED, "Failed: #{@fail_count}" if @fail_count > 0
