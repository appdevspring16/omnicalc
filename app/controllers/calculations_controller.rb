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

    @character_count_without_spaces = @text.gsub(" ", "").length

    #word count
    @text_downcase = @text.downcase
    @text_array = @text_downcase.scan(/\w+/)

    @word_count = @text_array.count

    @occurrences = @text_array.count(@special_word)

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

    #

    @apr_monthly = (@apr/100/12).to_f

    # ((1+r/12)^(years*12))
    @apr_compounded = ((1+(@apr_monthly.to_f))**(@years*12)).to_f

    @monthly_payment = @principal*(@apr_monthly)*(@apr_compounded)/(@apr_compounded-1)

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
    @minutes = @seconds.to_i/60
    @hours = @minutes.to_i/60
    @days = @hours.to_i/24
    @weeks = @days.to_i/7
    @years = @years.to_i/365

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

    @median = (@range.to_i/2).to_f

    @sum = @numbers.sum

    @mean = @sum/@count

    # Variance
    @dif_squared = 0
    @numbers.each do |num|
      @dif_squared = @dif_squared + ((num).to_i - @mean)**2

    end

    @variance = @dif_squared/@count
    # Variance end

    @standard_deviation = @variance**0.5

    # mode
    freq = @sorted_numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }

    @mode = @sorted_numbers.max_by  { |v| freq[v] }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
