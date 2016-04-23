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

    @character_count_without_spaces = @text.length - @text.split(" ").count + 1

    @word_count = @text.split(" ").count

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


      monthly_rate = @apr/100/12
      periods = @years*12
      pv = @principal

      @monthly_payment = ((monthly_rate*(1+monthly_rate)**periods)/((1+monthly_rate)**periods-1)*pv)


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
      @minutes = (@seconds/60).round
      @hours = @minutes/60.round
      @days = @hours/24.round
      @weeks = @days/7.round
      @years = @weeks/52.round

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

      @range = "#{@numbers[0]}" + " through " + "#{@numbers.last}"

      @median = "Replace this string with your answer."

      @sum = @numbers.sum

      @mean = @sum.to_f / @count

      @variance = "Replace this string with your answer."

      @standard_deviation = "Replace this string with your answer."

      @mode = "Replace this string with your answer."



      # ================================================================================
      # Your code goes above.
      # ================================================================================

      render("descriptive_statistics.html.erb")
    end
  end
