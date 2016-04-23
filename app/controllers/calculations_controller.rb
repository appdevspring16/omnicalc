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

    @character_count_without_spaces = @text.gsub(/\s+/, "").length

    @word_count = @text.split.count

    @aa = @text.downcase.split
    @q = 0

    for i in 1..@aa.count
      if @aa[i-1] == @special_word.downcase
        @q += 1
      end
    end

    @occurrences = @q

    # @text.count('t')

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f
    @mon_int = @apr/1200

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    @monthly_payment = (@principal * (@mon_int/(1-(1+@mon_int)**(@years*12*(-1)))))


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
    @minutes = ((@ending-@starting)/60).floor
    @hours = ((@ending-@starting)/3600).floor
    @days = (((@ending-@starting)/3600)/24).floor
    @weeks = ((((@ending-@starting)/3600)/24)/7).floor
    @years = (((((@ending-@starting)/3600)/24)/7)/365).floor

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

    @sorted = @numbers.sort

    if @count.even?
      @xx = (@sorted[(@count/2)-1]+@sorted[(@count/2)])/2
    else
      @xx = @sorted[(@count/2)]
    end

    @median = @xx

    @sum = @numbers.sum

    @mean = @sum/@count

    @nn = @count-1
    @rr = 0

    while @nn > -1
      @rr += (@sorted[@nn]-@mean)**2
      @nn -= 1
    end

    @variance = @rr/(@count-1)

    @standard_deviation = @variance**(0.5)

    @ar = []
    @mm = []
    for y in 1..(@count)
      @aq = 0
      for x in 1..@count
        if @numbers[y-1] == @numbers[x-1]
          @aq +=1
        end
      end
      @ar.push(@aq)
    end
    @br = []
    if @ar.max != 1
      for x in 1..@count
        if @ar[x] == @ar.max
          @br.push(@numbers[x])
        end
      end
    end

    @mode = @br.uniq

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
