class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]
    check_word = @special_word

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.chomp.length

    number_of_spaces = @text.count(" ")
    @character_count_without_spaces = @character_count_with_spaces - number_of_spaces

    text_array = @text.split
    @word_count = text_array.length

    i = 0

    text_array.each do |word_text|
      if word_text == check_word
        i = i + 1
      end
    end


    @occurrences = i

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
    apr_p = @apr/100/12
    @monthly_payment = @principal*apr_p/(1 - (1 + apr_p)**(-@years*12))

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

    @count = @numbers.length

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[@count-1]

    @range = @maximum - @minimum

    if @count.odd?
      @median = @sorted_numbers[@count/2]
    else
      @median = (@sorted_numbers[@count/2]+@sorted_numbers[@count/2-1])/2
    end

    sum_n = 0
    @numbers.each do |number|
      sum_n = sum_n + number
    end

    @sum = sum_n

    @mean = sum_n/@count

    sum_q = 0
    @numbers.each do |number|
      sum_q = sum_q + (number - @mean)**2
    end

    @variance = sum_q/@count

    @standard_deviation = @variance**0.5

    freq = []
    i = 0
    @numbers.each do |number|
      @numbers.each do |number_i|
        freq[i]=1
        if number_i == number
          freq[i] = freq[i] + 1
        end
        i = i + 1
      end
      i = 0
    end

    mode_index = freq.index(freq.sort[freq.length-1])

    @mode = @numbers[mode_index]

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
