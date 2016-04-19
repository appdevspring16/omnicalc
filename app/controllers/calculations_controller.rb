class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    @character_count_with_spaces = @text.length

    no_space = @text.gsub(" ","")
    @character_count_without_spaces = no_space.length

    x = 0
    count = 0
    while x < @text.length
      if @text[x] == " "
        count = count + 1
      end
      x = x + 1
    end

    if @text[@text.length-1] == " "
      @word_count = count
    else
      @word_count = count + 1
    end

    temp_text = @text.downcase
    @special_word = @special_word.downcase

    temp_text = temp_text.gsub(".","")
    temp_text = temp_text.gsub(",","")
    temp_text = temp_text.gsub("!","")
    temp_text = temp_text.gsub("?","")

    temp_text = temp_text.split
    @occurrences = temp_text.count(@special_word)

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    denom = 1 - ((1 + (@apr/100))**(-1*@years))


    @monthly_payment = (((@apr/100)/denom)*@principal)/12

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
    @years = @weeks/52.1429

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    if @count.odd? == true
      @median = @sorted_numbers[(@count/2).to_f]
    else
      @median = (@sorted_numbers[@count/2] + @sorted_numbers[(@count/2)-1])/2
    end

    part_total = 0
    @numbers.each do |number|
      part_total = part_total + number
    end

    @sum = part_total

    @mean = @sum / @count

    sq_diff = 0
    @numbers.each do |number|
      sq_diff = sq_diff + (number-@mean)**2
    end

    @variance = sq_diff / @count

    @standard_deviation = @variance**0.5

    @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
