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

    @character_count_without_spaces =   @text.squish.length - @text.squish.count(" ")

    @word_count = @text.scan(/\b/).size/2

    def count_em(string, substring)
      string.scan(/(?=#{substring})/).count
    end

    if @special_word.empty?
      @occurrences="0"
    else
    @occurrences = count_em(@text, @special_word)
    end
    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    apr = @apr
    apr = apr.to_f/1200
    years = @years
    principal = @principal
    nmonths = years.to_i*12
    mpayment = (apr*principal.to_f)/(1-((1+apr)**(-1*nmonths.to_i)))
    # ================================================================================

    @monthly_payment = mpayment.to_s

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    tdsec = @ending - @starting
    tdmin = tdsec.to_f/60
    tdhour= tdsec.to_f/3600
    tdday = tdsec.to_f/(3600*24)
    tdweek= tdsec.to_f/(3600*24*7)
    tdyear= tdsec.to_f/(3600*24*365)

    @seconds = tdsec.to_s
    @minutes = tdmin.to_s
    @hours = tdhour.to_s
    @days = tdday.to_s
    @weeks = tdweek.to_s
    @years = tdyear.to_s

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    fl_array = []
    fl_array = @numbers.map(&:to_f)
    sort_array = []
    sort_array = fl_array.sort
    mode_array = []
    total = 0
    medpos = 0
    stdev = 0.0
    vari = 0.0
    vars = 0.0
    mn = 0.0
    fl_array.each { |num| total = total + num }
    medpos = fl_array.length/2
    mn = total.to_f/fl_array.length
    fl_array.each { |numb| vars = vars + ((numb-mn)**2) }
    vari = vars/fl_array.length
    stdev = vari**0.5
    mdn = 0.0
    if fl_array.length.odd? == true
    mdn = sort_array[medpos]
    else
    mdn = (sort_array[medpos-1] + sort_array[medpos])/2
    end
    mod=Hash[sort_array.map {|k| [k, 0]}]

    @sorted_numbers = @numbers.sort

    @count = fl_array.length.to_s

    @minimum = fl_array.sort.first.to_s

    @maximum = fl_array.sort.last.to_s

    @range = (fl_array.sort.last-fl_array.sort.first).to_s

    @median = mdn.to_s

    @sum = total.to_s

    @mean = mn.to_s

    @variance = vari.to_s

    @standard_deviation = stdev.to_s


    @mode = mod[6].to_s

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
