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


    @character_count_without_spaces = @text.length-@text.count(" ")

count=0
i=0
while i<@text.length
if @text[i]==" " && @text[i-1]!=" "
  count=count+1
end
i=i+1
end

    @word_count =count+1
i=0
count=0
while i<@text.length
  if  @text.split[i]==@special_word && @text.split[i-1]=" " && @text.split[i+1]=" "
count=count+1
end
i=i+1
end
    @occurrences = count

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
    mon_apr=(@apr/12)/100
    n=@years*12
    rate=(1+mon_apr)**n
    var1=(mon_apr*@principal*rate)/(rate-1)
    @monthly_payment = var1

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
    @minutes = (@ending-@starting)/60
    @hours = ((@ending-@starting)/60)/60
    @days = (((@ending-@starting)/60)/60)/24
    @weeks = ((((@ending-@starting)/60)/60)/24)/7
    @years = (((((@ending-@starting)/60)/60)/24)/7)/52

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

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @maximum-@minimum


var1=@count/2
var2=@sorted_numbers[var1]
var3=@sorted_numbers[var1-1]
var4=(var2+var3)/2
if @count%2!=0
  @median=var2
else @median=var4
end


    @sum = @numbers.sum

    @mean = @sum/@count

i=0
running_total=0
while i<@numbers.length
  running=@numbers[i]-@mean
  running_total=running_total+(running**2)
   i=i+1
end


    @variance = running_total/@count

    @standard_deviation = Math.sqrt(@variance)
# i=0
# arr_created=[]
# while i<@numbers.length
#   holder=@numbers[i].count
#   arr_created=holder.push
# end
#
#arr_created.max

i=0
new_array=[]
count=0
while i<@numbers.length
  @numbers.each do |num|
    if num=@numbers[i]
      count=count+1
      new_array.push(count)
    end
  end
    i=i+1
  end

    @mode = new_array.max

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
