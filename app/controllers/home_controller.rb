class HomeController < ApplicationController
  def index
    # 1. Hard‑coded birth date for our single user
    birth_date = Date.new(1957, 10, 21)

    # 2. Determine the display date (single‑date form)
    @display_date = params[:date].present? ? Date.parse(params[:date]) : Date.today

    # 3. Compute numerology for the chosen date (without saving)
    @result = DailyNumerology.new(birth_date: birth_date)
    @result.compute_numerology(@display_date)

    # 4. Default for the next single‑date form
    @future_date = @display_date + 1

    # 5. New defaults for the date‑range form: tomorrow through tomorrow+6
    default_start = Date.today + 1
    default_end   = default_start + 6

    @range_start = params[:start_date].present? ? Date.parse(params[:start_date]) : default_start
    @range_end   = params[:end_date].present?   ? Date.parse(params[:end_date])   : default_end

    # 6. Build range results if both parameters supplied
    if params[:start_date].present? && params[:end_date].present?
      @range_results = (@range_start..@range_end).map do |d|
        dn = DailyNumerology.new(birth_date: birth_date)
        dn.compute_numerology(d)
        { date: d, numerology: dn }
      end
    end
  end

  def calendar_pdf
    # Hard‑coded birth date
    birth_date   = Date.new(1957, 10, 21)
    @range_start = Date.parse(params[:start_date])
    @range_end   = Date.parse(params[:end_date])

    # Build results for the PDF calendar
    @range_results = (@range_start..@range_end).map do |d|
      dn = DailyNumerology.new(birth_date: birth_date)
      dn.compute_numerology(d)
      { date: d, numerology: dn }
    end

    respond_to do |format|
      format.pdf do
        render pdf:       "calendar_#{@range_start.strftime('%Y_%m')}",
               template:  'home/print_calendar',
               layout:    'pdf',
               handlers:  [:erb],
               formats:   [:html],
               page_size: 'Letter',
               orientation: 'Landscape',
               margin:    { top: 10, bottom: 10, left: 10, right: 10 }
      end
    end
  end
end
