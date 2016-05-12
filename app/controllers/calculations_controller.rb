class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]
    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @word_count = @text.split.count


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.length - @text.count(" ") - @text.count("\n") - @text.count("\r") - @text.count("\t")

    uniform_text = @text.downcase
    @occurrences = uniform_text.split.count(@special_word.downcase) + uniform_text.split.count(@special_word.downcase + ".") + uniform_text.split.count(@special_word.downcase + ",") + uniform_text.split.count(@special_word.downcase + "?") + uniform_text.split.count(@special_word.downcase + "!") +
    uniform_text.split.count(@special_word.downcase + "-")

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

    @monthly_payment = (((@apr/12)/100) * @principal * ((1+((@apr/12)/100))**(@years*12)))/(((1+((@apr/12)/100))**(@years*12))-1)

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
    @minutes = (@ending-@starting)/60
    @hours = (@ending-@starting)/3600
    @days = (@ending-@starting)/86400
    @weeks = (@ending-@starting)/604800
    @years = (@ending-@starting)/31536000

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

    @range = @numbers.max - @numbers.min

    @median =
    if @count%2 == 1
      @sorted_numbers[(@sorted_numbers.length / 2)]
    elsif @count%2 == 0
      (@sorted_numbers[@sorted_numbers.length/2] + @sorted_numbers[@sorted_numbers.length/2-1]) / 2
    end

    @sum = 0
    @numbers.each do |number|
      @sum = @sum + number
    end

    @mean = @sum / @count

    @intermediate = @numbers.collect{|x| (x-@mean)**2}
    @variance = @intermediate.sum / @count

    @standard_deviation = @variance**0.5

    # @freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    # @mode = @numbers.max_by{ |v| @freq[v] }

    leader = nil
    leader_count = 0

        @numbers.each do |num|
          occurrences = @numbers.count(num)
          if occurrences > leader_count
            leader = num
            leader_count = occurrences
          end
        end

        @mode = leader


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
