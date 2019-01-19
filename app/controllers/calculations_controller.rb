class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    @text_no_space = @text.gsub(" ", "")
    @text_word_counter = @text.split.size
    # ================================================================================
    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text_no_space.length

    @word_count = @text_word_counter

    @occurrences = "I am not sure how to do this"

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

    @monthly_payment = "My code crashes the site. Please see my logic in the comments"
    # @monthly_payment = ((@principal*(1+(@apr/100))**@years)/(@years*12)

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

    @seconds = @ending - @starting
    @minutes =((@ending - @starting)/60).to_i
    @hours = (@minutes/60).to_i
    @days = (@hours/24).to_i
    @weeks = (@days/7).to_i
    @years = (@weeks/52).to_i

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    def median(descriptive_statistics)
      sorted = @numbers.sort
      len = sorted.length
      (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
    end

    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @sorted_numbers[0]

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @median = median(@numbers)

    @sum = "I did not manage to solve this on my own"

    @mean = "I did not manage to solve this on my own"

    @variance = "I did not manage to solve this on my own"

    @standard_deviation = "I did not manage to solve this on my own"

    @mode = "I did not manage to solve this on my own"

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
