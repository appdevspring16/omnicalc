

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

    @character_count_without_spaces = @text.gsub(" ","").length

    @word_count = @text.split(" ").length

    @occurrences = @text.downcase.gsub(/[^a-z0-9\s]/i, '').split(" ").count(@special_word.downcase)

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

    # P is monthly payments
    # L is total principal
    # c is monthly interest rate (or APR / 12)
    # n is the number of months of the loan
    c = (@apr*0.01)/12
    n = @years*12

    @monthly_payment = (c*@principal*((1+c)**n)) / (((1+c) ** n) -1)


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

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @median = (@sorted_numbers[(@count - 1) / 2] + @sorted_numbers[@count / 2]) / 2.0

    def sum(list_of_numbers)
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + number
      end

      return running_total
    end
    @sum = sum(@numbers)

    # MEAN
    # ====
    # To find the mean of a set,
    #  - we sum up all the elements
    #  - then we divide the sum by the number of elements in the set


    def avg(list_of_numbers)
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + number
      end
      n = list_of_numbers.length
      out = running_total / n

      return out
    end
  @mean = avg(@numbers)
  #  @mean = @sum / @count

    # VARIANCE
    # ========
    # To find the variance of a set,
    #  - we find the mean of the set
    #  - for each number in the set,
    #   - we find the difference between the number and the mean
    #   - we square the difference
    #  - the variance is the mean of the squared differences

    def varian(list_of_numbers)
      # Let's re-use the work we did above in the mean method

      # ====================
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + number
      end
      n = list_of_numbers.length
      out = running_total / n

      running_total2 = 0
      list_of_numbers.each do |number|
        running_total2 = ((out - number)**2) + running_total2
      end
      outvar = running_total2 / n

      return outvar

      # ====================
    end
    @variance = varian(@numbers)

    @standard_deviation = @variance ** 0.5

    def mode(list_of_numbers)
      freq = list_of_numbers.inject(Hash.new(0)) { |h,v| h[v] += 1;h }
      outmode = list_of_numbers.sort_by { |v| freq[v] }.last
      return outmode
    end

    @mode = mode(@numbers)

    render("descriptive_statistics.html.erb")
  end
end
