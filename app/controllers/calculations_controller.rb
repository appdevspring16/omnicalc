class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length.to_s

    @sanitized_text=@text.gsub(" ","")
    @character_count_without_spaces = @sanitized_text.length.to_s

    @wordlist=@text.split()
    @word_count = @wordlist.count

    @specials=0
    @wordlist.each do |word|
      if word==@special_word
        @specials=@specials+1
      else
      end
    end
    @occurrences = @specials

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
    @payments = @years*12
    @monthly_payment = ((@apr/100/12)*@principal)/(1-((1+(@apr/100/12))**(-1*@payments)))
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

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum-@minimum

    @median =
    if @count%2 != 0
      @median = @sorted_numbers[@count/2]
    else
      @median = (@sorted_numbers[count/2-1]+@sorted_numbers[count/2])/2
    end

    @total = 0
    @numbers.each do |num|
      @total=@total+num
    end
    @sum = @total
    @mean = @sum/@count

    @varnumbers=[]
    @numbers.each do |num|
      @varnumbers.push((@mean-num)**2)
    end
    @vartotal = 0
    @varnumbers.each do |num|
      @vartotal=@vartotal+num
    end
    @varsum = @vartotal
    @varmean = @varsum/@varnumbers.count
    @variance = @varmean



    @standard_deviation = @variance**0.5


    @modecounter=Hash.new(0)
    @numbers.each do |i|
      @modecounter[i] +=1
    end


    @mode_array=[]
    @modecounter.each do |k, v|
      if v == @modecounter.values.max
        @mode_array << k
      end
    end

    @mode=@mode_array.sort[0]

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
