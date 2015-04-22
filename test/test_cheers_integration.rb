require 'rubygems'
require 'bundler/setup'
require "minitest/reporters"

reporter_options = { color: true}
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

require "minitest/autorun"

class TestCheersIntegration < Minitest::Test

  def test_help_message
    output = `./cheers`
    expected = <<EOS
I'd cheer for you, if only I knew who you were :(
Try again with `./cheers.rb [Name] [MM/DD Birthday]`
EOS
    assert_equal expected, output
  end


  def test_invalid_name_if_empty_string
    output = `./cheers ""`
    expected = <<EOS
I'd cheer for you, if only I knew who you were :(
Try again with `./cheers.rb [Name] [MM/DD Birthday]`
EOS
    assert_equal expected, output
  end


  def test_invalid_name_if_whitespace
    output = `./cheers " "`
    expected = <<EOS
I'd cheer for you, if only I knew who you were :(
Try again with `./cheers.rb [Name] [MM/DD Birthday]`
EOS
    assert_equal expected, output
  end


  def test_one_invalid_argument_name
    output = `./cheers $M@lly`
    expected = <<EOS
I'd cheer for you, if only I knew who you were :(
Try again with `./cheers.rb [Name] [MM/DD Birthday]`
EOS
    assert_equal expected, output
  end


  def test_invalid_name_if_non_word_characters
    output = `./cheers 39%@1`
    expected = <<EOS
I'd cheer for you, if only I knew who you were :(
Try again with `./cheers.rb [Name] [MM/DD Birthday]`
EOS
    assert_equal expected, output
  end


  def test_birthday_instead_of_name
    output = `./cheers 08/19`
    expected = <<EOS
I'd cheer for you, if only I knew who you were :(
Try again with `./cheers.rb [Name] [MM/DD Birthday]`
EOS
    assert_equal expected, output
  end

  def test_one_valid_argument_name
    output = `./cheers Molly`
    expected = <<EOS
Give me an... M
Give me an... O
Give me an... L
Give me an... L
Give me a... Y
Molly's just GRAND!
I would wish you a Happy Birthday, if I knew when that was!
EOS
    assert_equal expected, output
  end

  def test_name_with_hypens
    output = `./cheers Mary-Ann`
    expected = <<EOS
Give me an... M
Give me an... A
Give me an... R
Give me a... Y
Give me an... A
Give me an... N
Give me an... N
Mary-Ann's just GRAND!
I would wish you a Happy Birthday, if I knew when that was!
EOS
    assert_equal expected, output
  end

  def test_one_invalid_name_one_valid_birthday
    output = `./cheers $M@lly 08/19`
    expected = <<EOS
I'd cheer for you, if only I knew who you were :(
Try again with `./cheers.rb [Name] [MM/DD Birthday]`
EOS
    assert_equal expected, output
  end


  def test_one_valid_name_one_invalid_birthday
    output = `./cheers Molly 08/19/2015`
    expected = <<EOS
Give me an... M
Give me an... O
Give me an... L
Give me an... L
Give me a... Y
Molly's just GRAND!
I would wish you a Happy Birthday, if I knew when that was!
EOS
    assert_equal expected, output
  end


  def test_two_invalid_arguments
    output = `./cheers $M@lly 08/19/2015`
    expected = <<EOS
I'd cheer for you, if only I knew who you were :(
Try again with `./cheers.rb [Name] [MM/DD Birthday]`
EOS
    assert_equal expected, output
  end


  def test_two_valid_arguments
    skip
    output = `./cheers Molly 08/19`
    expected = <<EOS
Give me an... M
Give me an... O
Give me an... L
Give me an... L
Give me a... Y
Molly’s just GRAND!

Awesome! Your birthday is in 121 days! Happy Birthday in advance!
EOS
    assert_equal expected, output
  end


  def test_valid_date_single_number_month
    skip
    output = `./cheers Molly 8/19`
    expected = <<EOS
Give me an... M
Give me an... O
Give me an... L
Give me an... L
Give me a... Y
Molly’s just GRAND!

Awesome! Your birthday is in 121 days! Happy Birthday in advance!
EOS
    assert_equal expected, output
  end


  def test_invalid_date_day_before_month
    skip
    output = `./cheers Molly 19/08`
    expected = <<EOS
I couldn't understand that. Could you give that to me in mm/dd format next time?
EOS
    assert_equal expected, output
  end


  def test_valid_date_birthday_already_happened_this_year
    skip
    output = `./cheers Molly 01/01`
    expected = <<EOS
Give me an... M
Give me an... O
Give me an... L
Give me an... L
Give me a... Y
Molly’s just GRAND!

Awesome! Your birthday is in 121 days! Happy Birthday in advance!
EOS
    assert_equal expected, output
  end

end
