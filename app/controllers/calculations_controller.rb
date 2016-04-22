class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    # text.split(' ').count


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.delete(' ').length

    @word_count = @text.split(' ').count

    @occurrences = @text.scan(@special_word).count

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

    @monthly_payment = @principal*((@apr/1200)*(1+(@apr/1200))**(@years*12))/(((1+(@apr/1200))**(@years*12))-1)

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

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

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

    @range = @numbers.max-@numbers.min

    if @sorted_numbers.length % 2 != 0
      @median =@sorted_numbers[(@sorted_numbers.length)/ 2.0]
    else
      @median =(@sorted_numbers[((@sorted_numbers.length-1)/2.0)] + @sorted_numbers[((@sorted_numbers.length)/2.0)])/2
    end

    @sum = @numbers.sum

    @mean = @sum/@count

    @variance = (@numbers.map{|x| (x-@mean)**2}.sum)/@count

    @standard_deviation = @variance**(0.5)

    @mode = @numbers.uniq.max_by{|x| @numbers.count(x)}

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
