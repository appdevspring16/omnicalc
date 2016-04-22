class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    length = @text.length
    spaces = @text.count " "

    @character_count_with_spaces = length

    @character_count_without_spaces = length - spaces

    @word_count = @text.split(/\s+/).length

    @occurrences = @text.scan(@special_word).length

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

    aprdivision = (@apr/12)/100

    @monthly_payment = (aprdivision + (aprdivision / (((1 + aprdivision)**(@years*12))-1))) * @principal

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

    @seconds = @ending.to_time.to_i - @starting.to_time.to_i
    @minutes = @seconds /60
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

    @range = @maximum - @minimum

    @median = (@sorted_numbers[(@sorted_numbers.length.to_f - 1)/2] + @sorted_numbers[(@sorted_numbers.length.to_f  )/2])/2

    @sum = @numbers.sum

    @mean = @sum/@count

    test = 0
    @numbers.each do |i|
      test = test + (i-@mean)**2
    end

    @variance = test.to_f/@count

    @standard_deviation = Math.sqrt(@variance)


    hash = Hash.new (0)
    @numbers.each do |i|
        hash[i] = hash[i] + 1
    end
    Hash

    largest = 0
    @numbers.each do |i|
        if hash[i] > largest
          largest = i
        else
          largest = largest
        end
    end

    @mode = largest 

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
