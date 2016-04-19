class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    @character_count_with_spaces = @text.length

    no_space = @text.gsub(" ","")
    @character_count_without_spaces = no_space.length

    x = 0
    count = 0
    while x < @text.length
      if @text[x] == " "
        count = count + 1
      end
      x = x + 1
    end

    if @text[@text.length-1] == " "
      @word_count = count
    else
      @word_count = count + 1
    end

    temp_text = @text.downcase
    @special_word = @special_word.downcase

    temp_text = temp_text.gsub(".","")
    temp_text = temp_text.gsub(",","")
    temp_text = temp_text.gsub("!","")
    temp_text = temp_text.gsub("?","")

    temp_text = temp_text.split
    @occurrences = temp_text.count(@special_word)

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    denom = 1 - ((1 + (@apr/100))**(-1*@years))


    @monthly_payment = (((@apr/100)/denom)*@principal)/12

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52.1429

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    if @count.odd? == true
      @median = @sorted_numbers[(@count/2).to_f]
    else
      @median = (@sorted_numbers[@count/2] + @sorted_numbers[(@count/2)-1])/2
    end

    part_total = 0
    @numbers.each do |number|
      part_total = part_total + number
    end

    @sum = part_total

    @mean = @sum / @count

    sq_diff = 0
    @numbers.each do |number|
      sq_diff = sq_diff + (number-@mean)**2
    end

    @variance = sq_diff / @count

    @standard_deviation = @variance**0.5

    max_count = 0
    @mode = 0
    @sorted_numbers.each do |number|
      if @sorted_numbers.count(number) > max_count
        max_count = @sorted_numbers.count(number)
        @mode = number
      end
    end

    render("descriptive_statistics.html.erb")
  end
end
