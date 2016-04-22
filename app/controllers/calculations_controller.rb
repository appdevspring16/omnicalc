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

    @character_count_without_spaces = @text.gsub(" ", "").length

    @word_count = @text.split(" ").length

    if @text.include?@special_word
      numSpecials = @text.split(" ").count(@special_word)
    end

    @occurrences = numSpecials

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

    mrate = @apr/100/12

    months = @years*12

    return_rate = 1+mrate

    denominator = return_rate**months-1

    @monthly_payment = ((mrate) + (mrate/denominator))*@principal

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

    @count = @numbers.count

    @minimum = @sorted_numbers.first

    @maximum = @sorted_numbers.last

    @range = @maximum - @minimum

    #median

    odd_middle_position = (@count-1)/2
    even_first_middle= (@count-1)/2
    even_second_middle= ((@count-1)/2) + 1

    if @count.odd? == true
      median=@sorted_numbers[odd_middle_position.to_i]
    elsif @count.odd? == false
      median= ((@sorted_numbers[even_first_middle] + @sorted_numbers[even_second_middle])/2).to_f
    end

    @median=median

    @sum = @numbers.sum

    @mean = @sum / @count

    def variance(list_of_numbers)
      number_mean_diff = 0
      list_of_numbers.each do |number|
        number_mean_diff = number_mean_diff + ((number - @mean)**2)
      end
      return number_mean_diff/@count
    end

    @variance = variance(@numbers)

    @standard_deviation = @variance**0.5

    # I found a helpful github about calculating mode and I almost understand it all given his/her nice comments
    # but I stll want to review some parts below (namely the last if statement)

    def mode(list_of_numbers)
      frequency = Hash.new(0)
      # -- other person's  note --
      # this creates a new, empty hash with no keys, but makes all defalt values zero. it will be used to store
      # the information from the array, such that the keys will be each unique number from the array (IOW, if there
      # are two or more 4's in the array, there will just be one key that is a 4), and the value for each key will
      # be the number of times that number appears in the array.
      list_of_numbers.each do |number|
        frequency[number] += 1
      end
      # -- other person's note --
      # this interates throught the array, and for each element it creates a key for that number (if it hasn't been
      # created already) and basically pushes a +1 to the value of that key. remember, the values all start at zero
      # because the "Hash.new" language included "(0)" at the end.
      mode_array = []
      # --other person's note --
      # this creates an empty array, to be filled with the most repeated number(s) from the array.
      # this will be the array that is returned at the end of the method.
      frequency.each do |k, v|
        if v == frequency.values.max
          mode_array << k
        end
      end
      # --other peron's note --
      # this loop iterates through the frequency array. for each key/value pair, it compares the value to
      # the high value in the array, and if the value it's comparing is equal to the high value, it
      # adds to the mode array the key associated with that value.
      mode_array.sort
    end

    @mode = mode(@numbers)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
