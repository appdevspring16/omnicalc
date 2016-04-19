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

    @character_count_without_spaces = @text.gsub(' ','').length

    wordsarray = @text.split(' ')

    @word_count = wordsarray.length

    @occurrences = @text.scan(/#{@special_word}/).length
    #  @occurrences = @special_word.class

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

    mrate = @apr/(12*100)
    period = -@years*12
    numerator = mrate*@principal
    denominator = 1-(1+mrate)**period
    @monthly_payment = numerator/denominator

    # @monthly_payment = "Replace this string with your answer."

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

    arraysize =  @numbers.sort.length
    if @numbers.sort.length%2 == 1
      midindex = arraysize/2
      @median = @numbers.sort[midindex]
    else  midindexlo = arraysize/2.round-1
      midindexhi = midindexlo+1
      @median = (@numbers.sort[midindexhi]+@numbers.sort[midindexlo])/2
    end

    # @median = median

    @sum = @numbers.sum

    @mean = @numbers.sum/@numbers.count

    devs = []
    mean = @mean
    numbers = @numbers
    numbers.each do |the_number|
      dev = the_number - mean
      devs.push(dev)
    end

    sqrdevs = []
    devs.each do |the_dev|
      sqrdev = the_dev*the_dev
      sqrdevs.push(sqrdev)
    end

    @variance=sqrdevs.sum/sqrdevs.length

    # @variance = "Replace this string with your answer."

    @standard_deviation = Math.sqrt(@variance)

sorted=@numbers.sort
def stringize(my_array)
  stringized=[]
  my_array.each do |elems|
    stringized.push(elems.to_s)
  end
  return stringized
end

    # @mode = "Replace this string with your answer."

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
