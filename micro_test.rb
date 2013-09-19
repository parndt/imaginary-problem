class MicroTest
  ANSI_GREEN = 32
  ANSI_RED   = 31

  def initialize(&test)
    @test = test
    @pass_count = 0
    @fail_count = 0
  end

  def check(values)
    values.each { |input, expected| check_result input, expected }
    puts_totals
  end

private

  def check_result(input, expected)
    actual = @test.call input
    if actual == expected
      pass "#{input.inspect} => #{actual.inspect}"
    else
      fail "Expected #{input.inspect} => #{expected.inspect}: got #{actual.inspect}"
    end
  end

  def pass(message)
    @pass_count += 1
    puts_color ANSI_GREEN, message
  end

  def fail(message)
    @fail_count += 1
    puts_color ANSI_RED, message
  end

  def puts_color(color_code, message)
    puts "\e[0;#{color_code}m" << message << "\e[0m"
  end

  def puts_totals
    puts '---'
    puts_color ANSI_GREEN, "Passed: #{@pass_count}" if @pass_count > 0
    puts_color ANSI_RED, "Failed: #{@fail_count}" if @fail_count > 0
  end

end
