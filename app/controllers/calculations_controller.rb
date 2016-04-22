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

    @character_count_without_spaces = (@text.gsub(" ","")).length

    @word_count = @text.split.size

    @occurrences = @text.scan(@special_word).count

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
    r = (@apr * 0.01)/12
    n = @years * 12

    @monthly_payment = (r * @principal)/(1-(1+r)**(-n))

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
    seconds = @ending - @starting
    @seconds = seconds.to_i

    minutes = seconds / 60
    @minutes = minutes.round(2)

    hours = minutes / 60
    @hours = hours.round(2)

    days = hours / 24
    @days = days.round(3)

    weeks = days / 7
    @weeks = weeks.round(3)

    years = weeks / 52
    @years = years.round(3)

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

    #median

    oddset_middle_position = (@count-1)/2
    evenset_first_middle= (@count-1)/2
    eventset_second_middle= ((@count-1)/2) + 1

    if @count.odd? == true
      median=@numbers.sort[oddset_middle_position.to_i]
    elsif @count.odd? == false
      median= ((@numbers.sort[evenset_first_middle] + @numbers.sort[eventset_second_middle])/2).to_f
    end

    @median=median

    #sum

    list_of_numbers = @numbers
    def sum(list_of_numbers)
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + number
      end
      return running_total
    end

    @sum= sum(list_of_numbers)

    #mean

    def mean(list_of_numbers)
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + number
      end
      return running_total/@count
    end

    @mean = mean(list_of_numbers)

    #variance

    def variance(list_of_numbers)
      number_mean_diff = 0
      list_of_numbers.each do |number|
        number_mean_diff = number_mean_diff + ((number - @mean)**2)
      end
      return number_mean_diff/@count
    end

    @variance = variance(list_of_numbers).round(2)

    @standard_deviation = (@variance**0.5).round(2)

    #mode

    counts = Hash.new 0
    @numbers.each do |number|
      counts[number] += 1
    end

    counts_hash=Hash[counts.sort_by{|k, v| v}.reverse]

    @mode = counts_hash.keys.first



    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
