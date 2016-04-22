class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================
    spl=@text.split(" ")

    @word_count = @text.split.count #working
    @character_count_with_spaces = @text.length
    @character_count_without_spaces = @text.gsub!(/\s+/,"").length
    @occurrences = spl.count(@special_word)

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
#P (for payment) = (i x A) / (1 - (1 + i)^-N).
    payment_per=0
    payment_per=@years*12

    monthly_apr=@apr/12/100

    monthly_interest=0.0
    monthly_interest=@principal*@apr/100



    @monthly_payment=(monthly_apr*@principal)/((1- (1+monthly_apr)**-payment_per))

    #@monthly_payment = (monthly_apr*@principal) / ((1-((1+monthly_apr)**payment_per)))



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
    dif= @ending - @starting
    @seconds = (dif/1.seconds).round
    @minutes = (dif/1.minutes).round
    @hours = (dif/1.hours).round
    @days = (dif/1.days).round
    @weeks = (dif/1.weeks).round
    @years = (dif/1.years).round

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




    @sorted_numbers = @numbers.sort()

    @count = @numbers.size

    @minimum = @sorted_numbers.first

    @maximum = @sorted_numbers.last

    @range = @maximum-@minimum

    @median = 0.0
    if @count%2 == 0 #even number
      @median = (@sorted_numbers[@count/2] + @sorted_numbers[@count/2-1])/2
    elsif
      @median = @sorted_numbers[@count/2]
    end

    @sum = @numbers.sum

    @mean = @sum/@count

    total=0.0

    @numbers.each do |num|
      total = total + (num - @mean)**2
    end

    @variance=total/(@count)

    @standard_deviation = @variance ** (1/2)

    @freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    @mode = @numbers.max_by{ |v| @freq[v] }


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
