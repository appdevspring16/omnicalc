class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    specialWordCount = 0
    @text.split(' ').each do |word|
      specialWordCount += 1 if word == @special_word
    end

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(/\s+/, '').length

    @word_count = @text.split(' ').length

    @occurrences = specialWordCount

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

    def pmt(rate, nper, pv)
      return (( rate / 100 / 12) * pv) / (1 - ((1 + (rate / 100 / 12)) ** (-nper * 12)))
    end

    @monthly_payment = pmt(@apr, @years, @principal).round(2)


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

    @seconds = @ending - @starting
    @minutes = @seconds / 60
    @hours = @minutes / 60
    @days = @hours / 24
    @weeks = @days / 7
    @years = @weeks / 52

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

    sumNumbers = 0

    @numbers.each do |number|
      sumNumbers += number
    end

    def median(sorted, count)
      if count.even?
        (sorted[count/2 - 1] + sorted[count/2]).to_f / 2
      else
        sorted[count/2]
      end
    end

    def variance(numbers, mean, count)
      var = 0
      numbers.each do |num|
        var += (num - mean) ** 2
      end
      return var / count
    end

    def mode(numbers)
      counts = Hash.new 0
      numbers.each do |num|
        counts[num] += 1
      end
      return countsDescending = counts.sort_by{|k,v| v}.reverse.first.first
    end

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @sorted_numbers.first

    @maximum = @sorted_numbers.reverse.first

    @range = @maximum - @minimum

    @median = median(@sorted_numbers, @count)

    @sum = sumNumbers

    @mean = @sum / @count

    @variance = variance(@numbers, @mean, @count)

    @standard_deviation = Math.sqrt(@variance)

    @mode = mode(@numbers)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
