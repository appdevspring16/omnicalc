class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.length-@text.count(" ")

    @word_count = @text.split(/\W+/).count

    @occurrences = @text.split(/\W+/).count(@special_word)

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    r=@apr/1200
    n=@years*12

    @monthly_payment = @principal*((r*((1+r)**n))/(((1+r)**n)-1))

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    @seconds = @ending-@starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @days/365.25

    render("time_between.html.erb")
  end

  def descriptive_statistics
    def mode(mode)
      mode_return = mode.inject({}) { |k, v| k[v] = mode.count(v); k }
      mode_return.select { |k,v| v == mode_return.values.max }.keys
    end


    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = [@numbers.min, @numbers.max]

    @median = (@sorted_numbers[(@count-1)/2]+@sorted_numbers[@count/2])/2

    @sum = @numbers.sum

    @mean = @sum/@count

    @variance = @numbers.inject(0){|accum,x| accum+(x-@mean)**2}/(@count-1)

    @standard_deviation = @variance**0.5

    @mode = mode(@numbers)

    render("descriptive_statistics.html.erb")
  end
end
