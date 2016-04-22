class CalculationsController < ApplicationController
  def without_spaces stringSample
    return stringSample.length - stringSample.count(' ')
  end
  def word_counter textArray
    return textArray.length
  end
  def occurances textArray,specWord
    count = 0
    for i in 0..textArray.length
      if textArray[i]==specWord
        count = count + 1
      end
    end
    return count
  end
  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    text = @text
    special_word = @special_word
    textArray = text.split(' ')

    @character_count_with_spaces = text.length

    @character_count_without_spaces = without_spaces(text)

    @word_count = word_counter(textArray)

    @occurrences = occurances(textArray,special_word)

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
    apr = @apr/(100*12)
    years = @years
    principal = @principal
    num = apr*principal
    power = (1+apr)**(-years*12)
    den = 1-power
    monthly_payment = num/den
    @monthly_payment = monthly_payment

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
    starting = @starting
    ending = @ending
    difference = ending-starting
    @seconds = difference
    @minutes = difference/60
    @hours = difference/(60*60)
    @days = difference/(60*60*24)
    @weeks = difference/(60*60*24*7)
    @years = difference/(60*60*24*365.25)

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

    numberArray = @numbers

    @sorted_numbers = numberArray.sort

    @count = numberArray.length

    @minimum = numberArray.min

    @maximum = numberArray.max

    @range = "Replace this string with your answer."

    @median = "Replace this string with your answer."

    @sum = "Replace this string with your answer."

    @mean = "Replace this string with your answer."

    @variance = "Replace this string with your answer."

    @standard_deviation = "Replace this string with your answer."

    @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
