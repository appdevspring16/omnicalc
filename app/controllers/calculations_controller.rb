class CalculationsController < ApplicationController

  # we don't use puts and gets for output and input anymore

  def word_count
    @text = params[:user_text]
    # variable @text retrieves the inputs from the form and @text is where the user input text
    # @text.gsub(/\s+/, "") remove all whitespace at once
    # @text.gsub(/[^a-z0-9\s]/i, '') remove anything but letters, digits, and whitespace all at once
    @special_word = params[:user_word]
    # The special word the user input is in the string @special_word.
    @character_count_with_spaces = @text.length # total count of all characters spaces and letters, etc.
    @character_count_without_spaces = @text.gsub(" ", "").length
    @word_count = @text.split.count #when splitting, it turns a text string into an array, disets the string into separate items as part of the array. count then counts how many of those newly items is created. Thats how we get word count without spaces.
    @occurrences = @text.split.count(@special_word.downcase)  #make sure to make downcase everything here so it can match any input of the user

    render("word_count.html.erb")
  end
  # =========================================================

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f   # @apr - the annual percentage rate
    @years = params[:number_of_years].to_i        # @years the number of years for the loan
    @principal = params[:principal_value].to_f    # @principal is in the decimal

    interest = (@apr/12)/100
    number_payments = @years*12

    @monthly_payment = (interest * @principal)/(1 -(1+ interest)**-number_payments)

    render("loan_payment.html.erb")
  end
  #==========================================================
  def time_between
    @starting = Chronic.parse(params[:starting_time])  #chronic is a gem
    @ending = Chronic.parse(params[:ending_time])

    # @starting The start time is in the Time
    # @ending The end time is in the Time
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #subtract STARTING from ENDING and you will get number of seconds
    @seconds = @ending - @starting
    @minutes = @seconds / (1 * 60)   #since Ruby stores in seconds, everything should be in seconds
    @hours = @seconds / (1 * 3600)
    @days = @seconds / 1.day  # or can do divide by (1*36000*24)
    @weeks = @seconds / 1.week
    @years = @seconds / 1.year

    render("time_between.html.erb")
  end
  #==========================================================
  
  # In the essential_ruby repository from class, there are some comments
  #  in 8_return_values.rb and challenge_1.rb that may be helpful for finding
  #  some of the formulae you'll need.

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # @numbers is the array where the user input numbers

    @sorted_numbers = @numbers.sort  #sort the numbers in ascending order

    @count = @numbers.count #how many data are in the set

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum #the difference between the largest and smallest values

    #MEDIAN - is the "middle" value in the list of numbers. Arrange all the observations from lowest value to highest value and pick the middle one. If there is an even number of observations, then the median is the mean of the two middle values [1] [2] (the median of {3, 5, 7, 9} is (5 + 7) / 2 = 6)

    if @count.odd?
      @median = @sorted_numbers[@count / 2] #this will not do the math, it will show th value in that position, which is what we need for median
    else
      middle_left = @sorted_numbers[(@count / 2) -1] #because the line up starts counting with 0, when lets say 8 is divided by 2, you get 4, but 4 points to the 5th place, so you need to go back one to be on the left side of the middle.
      middle_right = @sorted_numbers[(@count / 2)]
      @median = (middle_left + middle_right) / 2
    end

    # SUM
    # To find the sum of a set of numbers,
    #  - we start with 0
    #  - and then for each number in the set, we add it to the running total
    #  - after we've looked at every number, the running total is the sum
    # OR USE .sum  METHOD WHEN IN RAILS

    @sum = @numbers.sum #easy  (in ruy cannot use .sum, but in rails yes you can)

    # MEAN
    #  - we sum up all the elements
    #  - then we divide the sum by the number of elements in the set

    @mean = @sum / @count  #"Replace this string with your answer."

    # VARIANCE
    #  - we find the mean of the set
    #  - for each number in the set,
    #  - we find the difference between the number and the mean
    #  - we square the difference
    #  - the variance is the mean of the squared differences

    squared_differences = []
    @numbers.each do |number|  #for every number in our numbers array do the below
      difference = number - @mean
      squared_difference = difference ** 2  #** this means to the power of (so we are squaring here)
      squared_differences.push(squared_difference) #this will push the amount of squared diff to an array above. because we have numbers.each it will square each one
    end

    @variance = squared_differences.sum / @count

    #STANDARD DEVIATION
    # To find the standard deviation of a set,
    # #  - take the square root of the variance
    @standard_deviation = Math.sqrt(@variance) #math.sqrt its a ruby / rails method

    # MODE - is the value that appears most often in a set of data.
    frequent_value = nil #its nil because I don't know it yet
    frequent_count = 0 #we start with zero and then we will add

    @numbers.each do |number|
      appears = @numbers.count(number) #the number in parenthesis is the number above \number| this will count the number times each digit appears in the array
      if appears > frequent_count
        frequent_value = number
        frequent_count = appears
      end
    end
    @mode = frequent_value

    render("descriptive_statistics.html.erb")
  end
end

# ==========================================================
