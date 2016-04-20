class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    # total number of characters
    @character_count_with_spaces = @text.length

    # total characters without spaces
    @sanitized_text = @text.gsub(" ", "")
    @character_count_without_spaces = @sanitized_text.length

    # word count
    if @character_count_without_spaces > 0
      @word_count = @character_count_with_spaces -   @character_count_without_spaces + 1
    else
      @word_count = 0
    end

    # occurrences
    @text_array = @text.split
    @special_word = @special_word.downcase
    @count = 0
    @occurrences = 0

    while @count <= @text_array.length
      if @text_array[@count].to_s.downcase == @special_word
        @occurrences +=1
      end
      @count +=1
    end

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
    @interest = @apr / 100 / 12
    @months = @years * 12
    @ani = (1-(1+@interest)**(@months*-1)) / @interest
    @monthly_payment = @principal / @ani

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
    @minutes = @seconds / 60.0
    @hours = @minutes / 60.0
    @days = @hours / 24.0
    @weeks = @days / 7.0
    @years = @days / 365.25

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

    @maximum = @sorted_numbers[@count - 1]

    @range = @maximum - @minimum

    # median
    if @count%2 == 0
      @median = (@sorted_numbers[(1+@count)/2] + @sorted_numbers[(1+@count)/2 - 1]) / 2
    else
      @median = @sorted_numbers[(1+@count)/2 - 1]
    end

    @sum = 0
    @sorted_numbers.each do |sum|
      @sum += sum
    end

    @mean = @sum / @count

    # variance
    @var_sum = 0.0
    @sorted_numbers.each do |x|
      @var_sum += (x - @mean)**2
    end
    @variance = @var_sum / @count

    @standard_deviation = @variance**0.5

    # mode
    @index_mode = 0
    @count_mode = 1
    @max_mode = 1
    @mode_count = 1
    while @count_mode <= @count
      if @sorted_numbers[@count_mode] == @sorted_numbers[@count_mode - 1]
      @mode_count += 1
    elsif @mode_count > @max_mode
        @index_mode = @count_mode - 1
    end
    @count_mode += 1
    end
    @mode = @sorted_numbers[@index_mode]

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
