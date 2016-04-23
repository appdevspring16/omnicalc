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

    @character_count_without_spaces = @text.gsub(" ","").length

    @word_count = @text.length - @text.gsub(" ","").length + 1

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
    @monthly_int = @apr/(12*100)

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = (@principal * (@monthly_int/(1-(1+@monthly_int) ** (@years* -12.00))))

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

    @seconds = (@ending - @starting)/3600*60*60
    @minutes = (@ending - @starting)/3600*60
    @hours = (@ending - @starting)/3600
    @days = (@ending - @starting)/3600/24
    @weeks = (@ending - @starting)/3600/24/7
    @years = (@ending - @starting)/3600/24/365.25

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

    if @count.even?
      @middle = (@sorted_numbers[@count/2]+@sorted_numbers[@count/2+1])/2
    else
      @middle = @sorted_numbers[@count/2+0.5]
    end

    @median = @sorted_numbers[@middle]

    @sum = @numbers.sum

    @mean = @sum/@count

    @numbers.each do |number|
    @veriance1 = (number-@mean)**2
    end

    @variance = @veriance1/@count

    @standard_deviation = @variance**0.5

    @freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

    @mode = @numbers.max_by{ |v| @freq[v] }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
