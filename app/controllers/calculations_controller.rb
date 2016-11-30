class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @text_no_space = @text.gsub(/\s+/, "")

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text_no_space.length

    @word_count = @text.split.length

    @occurrences = @text.split.count(@special_word)

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

    @apr_monthly = @apr/(12*100)
    @nper = @years*12

      # =========================================================
      # Your code to implement the method goes here.
      # You shouldn't have to write or change code anywhere else.
      # =========================================================

## to be honest I haven't studied finance, but I get the coding idea!
    @monthly_payment = (@apr_monthly*@principal)/((1-(1+@apr_monthly))**(1/@nper))
      #@monthly_payment = ((@principal*@apr_monthly)/((1+@apr_monthly)**@nper)-1)
    # ================================================================================v
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

    @seconds = (@ending - @starting).abs
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365

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

    @numbers_sorted = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = "Replace this string with your answer."

    @median = "Replace this string with your answer."

    # SUM
    # ===
    # To find the sum of a set of numbers,
    #  - we start with 0
    #  - for each number in the set,
    #   - we add it to the running total
    #  - after we've looked at every number, the running total is the sum
    def sum(@numbers)
      running_total = 0
      numbers.each do |number|
      running_total = running_total + number
    end

      return running_total
    end
    # MEAN
    # ====
    # To find the mean of a set,
    #  - we sum up all the elements
    #  - then we divide the sum by the number of elements in the set

    def mean(@numbers)
      # Let's re-use the work we did above in the sum method

      # ====================
      # Your code goes here.
      # ====================
    end

    # VARIANCE
    # ========
    # To find the variance of a set,
    #  - we find the mean of the set
    #  - for each number in the set,
    #   - we find the difference between the number and the mean
    #   - we square the difference
    #  - the variance is the mean of the squared differences

    def variance(list_of_numbers)
      # Let's re-use the work we did above in the mean method

      # ====================
      # Your code goes here.
      # ====================
    end

    # STANDARD DEVIATION
    # ==================
    # To find the standard deviation of a set,
    #  - take the square root of the variance

    def standard_deviation(list_of_numbers)
      # ====================
      # Your code goes here.
      # ====================
    end

    @mode = mode(@sorted_numbers)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
