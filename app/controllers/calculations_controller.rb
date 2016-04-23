class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]


    text_down = @text.downcase
    #need to stop removing punctuation
    text_strip = text_down.gsub(/\s+/,"")
    text_scrubbed = text_down.gsub(/[^a-z0-9\s]/i, "")
    word_array = text_scrubbed.split(/\W+/)

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = text_strip.length

    @word_count = word_array.length

    match_word = @special_word.downcase
    match_word = match_word.gsub(/[^a-z0-9\s]/i,"")
    special_cnt = 0

    word_array.each do |word|
      if word == match_word.downcase
        special_cnt = special_cnt +1
      end
    end

    @occurrences = special_cnt

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
    months = @years * 12
    rate = @apr / 12 / 100

    @monthly_payment = (rate * @principal * ((1 + rate) ** months)) / (((1 + rate) ** months) - 1)

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
    @years = @weeks / (365.25 / 52)

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

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[@count-1]

    @range = @maximum - @minimum

    midpoint = (@count.to_f / 2)

    if midpoint == midpoint.floor
      @median = (@sorted_numbers[midpoint] + @sorted_numbers[midpoint + 1])/2
    else
      midpoint = midpoint.floor
      @median = @sorted_numbers[midpoint]
    end

    running_sum = 0

    @numbers.each do |number|
      running_sum = running_sum + number
    end

    @sum = running_sum

    @mean = @sum / @count
     var_sum = 0

    @numbers.each do |number|
      var_sum = var_sum + (number - @mean) ** 2
    end

    @variance = var_sum / @count

    @standard_deviation = (@variance) ** (0.5)

    numbers_unique = @numbers.uniq

    mode_array = Array.new

    numbers_unique.each do |uniq_num|
      mode_cnt = 0
      idx = 0
      while idx < @sorted_numbers.length
        if uniq_num == @sorted_numbers[idx]
          mode_cnt = mode_cnt +1
          idx = idx + 1
        else
          idx = idx +1
        end
      end
      mode_array.push(mode_cnt)
    end

    mode_array_sort = mode_array.sort

    mode_idx = mode_array.index(mode_array_sort[mode_array_sort.length-1])

    @mode = numbers_unique[mode_idx]

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
