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
    @without_spaces = 0
    for x in @text.split(" ")
      @without_spaces = @without_spaces + x.length
    end
    @character_count_without_spaces = @without_spaces


    @word_count = @text.split(" ").length
    @special = 0
    for x in @text.chop.split(" ")
      if x == @special_word.chomp
        @special = @special + 1
      end
    end
    @occurrences = @special

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
    @rate=@apr/12.0
    @rate = @rate*0.01
    @months = @years*12
    @monthly_payment = (@rate*@principal)/(1.0-((1.0+@rate)**(-@months)))

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
    @minutes = @seconds/60.0
    @hours = @minutes/60.0
    @days = @hours/24.0
    @weeks = @days/7.0
    @years = @weeks/52.0

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

    @maximum = @sorted_numbers[-1]

    @range = @maximum - @minimum

    @middle = @count/2
    if @count.even? == true
      @median = (@sorted_numbers[@middle] + @sorted_numbers[@middle + 1])/2
    else @median = @sorted_numbers[@middle]
    end

    @running_total = 0
    @numbers.each do |number|
      @running_total = @running_total + number
    end
    @sum = @running_total

    @mean = @sum/@count

    @variance = 0
    @numbers.each do |number|
      @squared_difference = (number - @mean)**2
      @variance  = @variance + @squared_difference
    end
    @variance = @variance/@count

    @standard_deviation = Math.sqrt(@variance)

    @number_hash = Hash.new
    @numbers.each do |number|
      if @number_hash.include? number
        @number_hash[number] = @number_hash[number] + 1
      else
        @number_hash[number] = 1
      end
    end
    @mode = 0
    @values = @number_hash.map(&:last)
    @number_hash.each do |number|
      if number[1] == @values.max
        @mode = number[0]
      end
    end


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
