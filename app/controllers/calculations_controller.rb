class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    character_count_with_spaces = @text.length

    character_count_without_spaces = @text.gsub(" ","").length

    if @text.include?(@special_word)
      occurences = @text.split.count(@special_word)
    else
    end



    @character_count_with_spaces = character_count_with_spaces

    @character_count_without_spaces = character_count_without_spaces

    @word_count = @text.split.count

    @occurrences = occurences

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

  monthlyinterest = @apr/100/12
  months = @years*12

  monthly_payment = (monthlyinterest*@principal*(1+monthlyinterest)**months)/((1+monthlyinterest)**months-1)



    @monthly_payment = monthly_payment

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    starting = @starting.to_f
  ending = @ending.to_f
  difference = ending - starting


    @seconds = difference
    @minutes = difference / 60
    @hours = difference / 3600
    @days = difference / 3600 / 24
    @weeks = difference/ 3600 / 24/ 7
    @years = difference / 3600/ 24/ 7/ (365.25/7)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)


    def sorted_numbers(list_of_numbers)
    list_of_numbers.sort
    end

    def count(list_of_numbers)
    list_of_numbers.count
    end

    def min(list_of_numbers)
    list_of_numbers.sort[0]
    end

      def max(list_of_numbers)
    list_of_numbers.sort[list_of_numbers.length-1]
    end

    def range(list_of_numbers)
    max(list_of_numbers) - min(list_of_numbers)
    end

    def median(list_of_numbers)
      if (list_of_numbers.count).odd?
        list_of_numbers.sort[list_of_numbers.count/2]
      else
    ((list_of_numbers.sort[list_of_numbers.count/2])+(list_of_numbers.sort[list_of_numbers.count/2-1]))/2
      end
    end


    def sum(list_of_numbers)
      running_total = 0
      list_of_numbers.each do |number|
        running_total = running_total + number
      end

      return running_total
    end


    def mean(list_of_numbers)

    return (sum(list_of_numbers)*10.0/10.0/list_of_numbers.length)
    end

    def variance(list_of_numbers)
      squaredsum = 0
      list_of_numbers.each do |number|
       squaredsum = squaredsum + ((number - mean(list_of_numbers))**2)
      end
    return squaredsum/list_of_numbers.length
    end

    def standard_deviation(list_of_numbers)
      variance(list_of_numbers)**0.5
    end

    def mode(list_of_numbers)
      counter = Hash.new (0)
      list_of_numbers.each do |i|
        counter[i] = counter[i]+1
      end
    counter.key(counter.values.max)
    end




    @sorted_numbers = sorted_numbers(@numbers)

    @count = count(@numbers)

    @minimum = min(@numbers)

    @maximum = max(@numbers)

    @range = range(@numbers)

    @median = median(@numbers)

    @sum = sum(@numbers)

    @mean = mean(@numbers)

    @variance = variance(@numbers)

    @standard_deviation = standard_deviation(@numbers)

    @mode = mode(@numbers)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
