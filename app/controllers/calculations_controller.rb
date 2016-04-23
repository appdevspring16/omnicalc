class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @character_count_with_spaces = @text.length

    text_without_spaces = @text.gsub(" ", "").length

    @character_count_without_spaces = text_without_spaces

    words = @text.gsub(" ",", ")
    words_array = []
    words_array.push(words)

    @word_count = "Replace this string with your answer."

    @occurrences = "Occurences of a special word."

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

    rate = @apr / 100 / 12
    months = @years * 12

    numerator = (@principal * rate)
    denominator = 1 - (1 + rate)**-months
    calculated_payment = numerator / denominator

    @monthly_payment = calculated_payment

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

    # starting_time = @starting
    # ending_time = @ending_time
    # time_difference = ending_time - starting_time
    # time.diff()

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

    @sorted_numbers = @numbers.sort

    count = @numbers.count
    @count = count

    @minimum = @numbers.sort.first

    @maximum = @numbers.sort.last

    @range = @maximum - @minimum

    median_count = (count.to_f / 2).round

    if median_count.odd?
      @median = @sorted_numbers[median_count -1]
    else
      @median = (@sorted_numbers[median_count - 1] + @sorted_numbers[median_count]) / 2
    end


    sum = 0
    @numbers.each do |i|
    sum += i
    end

    @sum = sum

    @mean = sum / count

    variance_array = []

    @sorted_numbers.each do |var_num|
      variance_array.push((var_num - @mean)**2)
    end

    variance_sum = 0
      variance_array.each do |i|
      variance_sum += i
    end

    @variance = variance_sum / count

    @standard_deviation = @variance **(1/2)

    @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
