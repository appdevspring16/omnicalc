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

    @character_count_without_spaces = @text.delete(' ').length

    i = @text
    i = i.split(" ")
    a = 0
    i.each do
      a = a + 1
    end
    b = 0
    x = @special_word.downcase
    i.each do |lang|
      lang_2=lang.downcase.gsub(/[^a-z0-9\s]/i, '')
      if lang_2==x
        b=b+1
      end
    end

    @word_count = a

    @occurrences = b

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

    r = @apr/(12.0*100)
    m = @years*12
    p=@principal
    c= (p*r)/(1-(1/((1+r)**m)))
    @monthly_payment = c

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
    @minutes = (@ending - @starting)/60
    @hours = (@ending - @starting)/(60*60)
    @days = (@ending - @starting)/(60*60*24)
    @weeks = (@ending - @starting)/(60*60*24*7)
    @years = (@ending - @starting)/(60*60*24*365)

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


    n=0
    @numbers.each do
      n= n+1
    end

    @count = n

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[-1]

    @range = @maximum-@minimum

    if n%2==0
      med = (@sorted_numbers[n/2]+@sorted_numbers[n/2-1])/2
    else
      med = @sorted_numbers[(n-1)/2]

    end
    @median = med

    suma=0
    @numbers.each do |num|
      suma = suma + num
    end

    @sum = suma

    @mean = @sum/@count

    var=0
    @numbers.each do |num|
      var = var + (num - @mean)**2
    end
    var = var/n

    @variance = var

    @standard_deviation = var**(1.0/2.0)

    freq=[0]*n

    t=0
    f=0
    while t < n
      @numbers.each do |numero|
        if numero==@numbers[t]
          f=f+1
        end
      end
      freq[t]=f
      f=0
      t=t+1
    end
    table =  @numbers.zip(freq).to_h
    table_sorted = table.sort_by { |num, freq| freq}


    @mode = table_sorted.to_h.keys[-1]

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
