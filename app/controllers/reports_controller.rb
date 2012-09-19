class ReportsController < ApplicationController
  expose(:facility) { Facility.find(params[:report][:facility_id]) if params[:report][:facility_id] }
  respond_to :html, :json
  def index
  end

  def inmate
  end

  def generate
    start_day = params[:report]['start_date(1i)'].to_i
    start_month = params[:report]['start_date(2i)'].to_i
    start_year = params[:report]['start_date(3i)'].to_i
    start_date = Date.new(start_day, start_month, start_year)

    end_day = params[:report]['end_date(1i)'].to_i
    end_month = params[:report]['end_date(2i)'].to_i
    end_year = params[:report]['end_date(3i)'].to_i
    end_date = Date.new(end_day, end_month, end_year)

    case params[:report][:name]
    when 'Accountability'
      begin
        @results, @months = Report.accountability(start_date, end_date, {:facility_id => facility.id})
      rescue
        @results, @months = Report.accountability(start_date, end_date) 
      end
      respond_to do |format|
        format.html { render 'accountability' }
        format.json { head :no_content }
      end
    when 'Incident'
      @incidents, @months = Report.incident(params[:report][:status])
      respond_to do |format|
        format.html { render 'incident' }
        format.json { head :no_content }
      end
    end
  end

  def accountability
  end

  def incident
  end
end
