class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================

    @character_count_with_spaces = @text.length();

    # gsub - global substitute all white space and then count the characters
    @character_count_without_spaces = @text.gsub(" ", "").length();

    # split with string space ' ' ignores leading whitespaces and continuous spaces
    # split returns an array. so find the size for word count
    @word_count = @text.split(" ").size;

    # does not work as "t" matches "test" twice
    # Question: SG:
    # @occurrences = @text.scan(@special_word).size();
    #
    # Question 2: SG
    # # split into word array and update count hash with each word as key
    # # since hash key is unique we will have count at the end
    # @text.split(" ").each { |val|
    #   # first occurrence of the word in val
    #   if (! count[val])
    #     count[val] = 1
    #     # repeat occurrence of the work in val. so just increment
    #   else
    #     count[val] += 1
    #   }
    #
    #   if (! count[@special_word])
    #     @occurrences = 0;
    #   else
    #     @occurrences = count[@special_word];

    # split into word array and update count hash with each word as key
    # since hash key is unique we will have count at the end
    #  default is 0
    # Question: SG: why no @ for count
    count = Hash.new(0);
    @text.split(" ").each { |val| count[val] += 1}

    @occurrences = count[@special_word];

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

    # formula = p * r * (1 + r)^n / ((1 + r)^n - 1)
    # monthly interest rate
    @r = (@apr/12)/100;
    # period in months
    @n = @years * 12;

    @one_plus_r_power_n = ( 1 + @r) ** @n;


    @monthly_payment = ( @principal * @r * @one_plus_r_power_n) / (@one_plus_r_power_n - 1);

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

    @seconds = @ending - @starting;
    @minutes = @seconds/60
    @hours = @minutes/60;
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52

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

    @count = @numbers.size

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum - @minimum

    # Question: SG: why ? after odd
    if (@count.odd?)
      @median = @sorted_numbers[@count/2]
    else
      @median = ( @sorted_numbers[@count/2] + @sorted_numbers[(@count/2)-1] ) / 2;
    end

    @sum = 0;
    # Question: SG: below @num does not work. when to use @ and when not to?
    # @numbers.each { |@num| @sum += @num; }
    @numbers.each { |num| @sum += num; }

    @mean = @sum/@count

    @variance = 0
    @numbers.each { |num| @variance += (num - @mean)**2; }
    @variance /= @count

    @standard_deviation = @variance**0.5

    count = Hash.new(0);
    @numbers.each { |num| count[num] += 1 }

    # start by keeping the first number as mode
    # @mode = @numbers[0]
    # @numbers.each { |num|
    #   if (count[num] > count[@mode])
    #     @mode = num
    #   end
    # }


    # using keys of the count hash
    # better than previous method as long as at least one number happens twice or more
    @mode = @numbers[0]
    count.keys.each { |num|
      puts "num = #{num} count = #{count[num]}"
      if (count[num] > count[@mode])
        @mode = num
      end
    }
    #
    # @mode = @numbers[0]
    # # Note: Cant use hash.each as it gives key val as pairs for parsing
    # # puts "type of count = #{count.class}"
    # count.each { |v|
    #   puts "v = #{v} count[v] = #{count[v]}"
    #   if (count[v] > count[@mode])
    #     @mode = v
    #   end
    # }

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
