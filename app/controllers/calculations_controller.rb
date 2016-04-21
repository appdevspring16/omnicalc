class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    clean_text = @text.gsub(" ", "")
    @character_count_with_spaces = @text.length

    @character_count_without_spaces = clean_text.length

    @word_count = @text.gsub(/[^-a-zA-Z]/, ' ').split.size
    if @special_word != ""
      @occurrences = @text.downcase.scan(/(?=#{@special_word.downcase})/).count
    else
      @occurrences =0
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

    @monthly_payment = (@principal*(1+(@apr/100))**@years)/(12*@years)




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

    @range = "From #{@numbers.min} to #{@numbers.max}."

    if @sorted_numbers.length%2!=0
      @median = @sorted_numbers[(@sorted_numbers.length-1)/2]
    else
      @median =( @sorted_numbers[@sorted_numbers.length/2]+@sorted_numbers[(@sorted_numbers.length/2)-1])/2
    end

    def sum(list_of_numbers)
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + number
      end
      return running_total
    end
    @sum = sum(@numbers)

    @mean = @sum/@numbers.count

    def var(list_of_numbers)
      running_variance = 0
      list_of_numbers.each do |number|
        running_variance = running_variance + (number-@mean)**2
      end
      return running_variance
    end

    @variance = var(@numbers)


    @standard_deviation = @variance**0.5

    def mode(list_of_numbers)
      hash = Hash.new(0)
      list_of_numbers.each do |number|
        hash[number] = hash[number]+1
      end
      return hash
      end

    @mode = mode(@numbers)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
