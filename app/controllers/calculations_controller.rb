class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @character_count_with_spaces = @text.length();

    # gsub - global substitute all white space and then count the characters
    @character_count_without_spaces = @text.gsub(" ", "").length();

    # split with string space ' ' ignores leading whitespaces and continuous spaces
    # split returns an array. so find the size for word count
    @word_count = @text.split(" ").size;

    # does not work as "t" matches "test" twice
    # Question: SG:
    # @occurrences = @text.scan(@special_word).size();
    #
    # Question 2: SG
    # # split into word array and update count hash with each word as key
    # # since hash key is unique we will have count at the end
    # @text.split(" ").each { |val|
    #   # first occurrence of the word in val
    #   if (! count[val])
    #     count[val] = 1
    #     # repeat occurrence of the work in val. so just increment
    #   else
    #     count[val] += 1
    #   }
    #
    #   if (! count[@special_word])
    #     @occurrences = 0;
    #   else
    #     @occurrences = count[@special_word];

    # split into word array and update count hash with each word as key
    # since hash key is unique we will have count at the end
    #  default is 0
    count = Hash.new(0);
    @text.split(" ").each { |val| count[val] += 1}

    @occurrences = count[@special_word];

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    # formula = p * r * (1 + r)^n / ((1 + r)^n - 1)
# monthly interest rate
    @r = (@apr/12)/100;
    # period in months
    @n = @years * 12;

    @one_plus_r_power_n = ( 1 + @r) ** @n;


    @monthly_payment = ( @principal * @r * @one_plus_r_power_n) / (@one_plus_r_power_n - 1);

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = "Replace this string with your answer."
    @minutes = "Replace this string with your answer."
    @hours = "Replace this string with your answer."
    @days = "Replace this string with your answer."
    @weeks = "Replace this string with your answer."
    @years = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = "Replace this string with your answer."

    @count = "Replace this string with your answer."

    @minimum = "Replace this string with your answer."

    @maximum = "Replace this string with your answer."

    @range = "Replace this string with your answer."

    @median = "Replace this string with your answer."

    @sum = "Replace this string with your answer."

    @mean = "Replace this string with your answer."

    @variance = "Replace this string with your answer."

    @standard_deviation = "Replace this string with your answer."

    @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
