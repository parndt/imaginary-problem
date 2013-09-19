
def f(n)
  case n
  when Numeric then Proc.new { n * -1 }
  when Proc    then n.call
  end
end

# -- Test "framework"

class MicroTest
  ANSI_GREEN = 32
  ANSI_RED   = 31

  def initialize(&test)
    @test = test
    @pass_count = 0
    @fail_count = 0
  end

  def check(values)
    values.each do |input, expected|
      actual = @test.call input
      if actual == expected
        @pass_count += 1
        puts_color ANSI_GREEN, "#{input.inspect} => #{actual.inspect}"
      else
        @fail_count += 1
        puts_color ANSI_RED, "Expected #{input.inspect} => #{expected.inspect}: got #{actual.inspect}"
      end
    end

    puts '---'
    puts_color ANSI_GREEN, "Passed: #{@pass_count}" if @pass_count > 0
    puts_color ANSI_RED, "Failed: #{@fail_count}" if @fail_count > 0
  end

private

  def puts_color(color_code, message)
    puts "\e[0;#{color_code}m" << message << "\e[0m"
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
