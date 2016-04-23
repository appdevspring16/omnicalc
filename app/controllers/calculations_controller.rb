class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @character_count_with_spaces = @text.size

    @character_count_without_spaces = @text.count("^ ")

    @word_count = @text.count(" ") + 1

    @occurrences = @text.scan(/(?=#{@special_word})/).count

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

    @n = 12 * @years

    @r = @apr / 12 / 100



    @monthly_payment = (@r * @principal) / (1 - (( 1 + @r)) ** -@n)

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

    @seconds_diff = (@starting - @ending).to_i.abs


    @seconds = @seconds_diff
    @minutes = @seconds_diff / 60
    @hours = @seconds_diff / 3600
    @days = @hours / 24
    @weeks = @days / 7
    @years = @days / 365

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

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @sorted = @numbers.sort
    @len = @sorted.length

    @median = (@sorted[(@len - 1) / 2] + @sorted[@len / 2]) / 2.0

    @sum = @numbers.inject(0){|sum,x| sum + x }

    @mean = @numbers.inject{ |sum, x| sum + x }.to_f / @numbers.size

    @numbers_minus_mean = @numbers.map { |i| i - @mean }

    @differences_squared = @numbers_minus_mean.map { |i| i ** 2 }

    @variance = @differences_squared.inject{ |sum, x| sum + x }.to_f / @differences_squared.size

    @standard_deviation = Math.sqrt(@variance)

    @freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

    @mode = @numbers.max_by { |v| @freq[v] }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
