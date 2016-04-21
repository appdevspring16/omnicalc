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
    @space_count = @text.split.count-1
    @character_count_without_spaces = @character_count_with_spaces-@space_count
    @word_count = @text.scan(/\S+/).size
    @occurrences = @text.split.count(@special_word)
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
    @months = @years*12
    @monthly_rate = @apr / (12*100)
    @monthly_payment=(@monthly_rate+(@monthly_rate/(((1+@monthly_rate)**(@years*12))-1)))*@principal


    # @monthly_payment = "Replace this string with your answer."

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

    @seconds = (@ending - @starting).abs
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365

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

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @median = (@sorted_numbers[(@count - 1) / 2] + @sorted_numbers[@count / 2]) / 2.0

    @sum = @numbers.sum

    @mean = (@sorted_numbers.inject(0.0) {|s,x| s + x}) / Float(@sorted_numbers.length)

    @variance = (@sorted_numbers.inject(0.0) {|s,x| s + (x - @mean)**2})/@count

        @standard_deviation =Math.sqrt(@variance)

    def mode(array)
    counter = Hash.new(0)

    array.each do |i|
      counter[i] += 1
    end

    mode_array = []

    counter.each do |k, v|
      if v == counter.values.max
        mode_array << k
      end
    end

    mode_array.sort
  
  end


    @mode = mode(@sorted_numbers)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
