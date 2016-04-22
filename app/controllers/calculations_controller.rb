class CalculationsController < ApplicationController

  def word_count

    @text = params[:user_text]
    @special_word = params[:user_word]

    characters = @text.split("")
    @character_count_with_spaces = characters.length

    characters_nospaces = characters-[" "]
    @character_count_without_spaces = characters_nospaces.length

    words = @text.split(" ")
    @word_count = words.length

    special_word_count = 0
    words.each do |word|
      if word == @special_word
        special_word_count += 1
      end
    end
    @occurrences = special_word_count

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    monthly_apr = @apr/12.0/100
    months = @years*12.0

    @monthly_payment = @principal * (monthly_apr + monthly_apr / ((monthly_apr + 1)**months - 1))

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
    @years = @weeks/52.1785714286

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    @sorted_numbers = @numbers.sort

    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    @median = (@sorted_numbers[@count/2] + @sorted_numbers[(@count-1)/2]) / 2.0

    @sum = 0
    @numbers.each do |number|
      @sum += number
    end

    @mean = @sum/@count

    variance_sum = 0
    expected_variance = 0
    @numbers.each do |number|
      variance_sum += (@mean-number)**2
      expected_variance = variance_sum/@count
    end
    @variance = expected_variance

    @standard_deviation = @variance**(1.0/2.0)

    occurances = []
    @numbers.each do |number|
      occurances.push(@numbers.count(number))
    end
    @mode = @numbers[occurances.index(occurances.max)]

    render("descriptive_statistics.html.erb")
  end
end
