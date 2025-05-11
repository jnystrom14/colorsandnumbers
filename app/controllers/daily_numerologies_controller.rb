class DailyNumerologiesController < ApplicationController
  # GET /daily_numerologies/new
  def new
    @daily_numerology = DailyNumerology.new
  end

  # POST /daily_numerologies
  def create
    @daily_numerology = DailyNumerology.new(daily_numerology_params)

    respond_to do |format|
      if @daily_numerology.save
        # Store birth date in a persistent cookie for convenience
        cookies.permanent[:birth_date] = @daily_numerology.birth_date.to_s

        format.html { redirect_to @daily_numerology }
        format.json { render :show, status: :created, location: @daily_numerology }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @daily_numerology.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /daily_numerologies/:id
  def show
    @daily_numerology = DailyNumerology.find(params[:id])
  end

  private

  # Only allow the birth_date parameter (others are auto‑computed)
  def daily_numerology_params
    params.require(:daily_numerology).permit(:birth_date)
  end
end
