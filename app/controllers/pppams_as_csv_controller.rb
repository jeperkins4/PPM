require 'faster_csv.rb'

class PppamsAsCsvController < ApplicationController
  
  # example action to return the contents
  # of a table in CSV format
  def export_all
    users = PppamsCategory.find(:all)
    stream_csv do |csv|
      csv << ["name","description","facility_id","created_on","updated_on"]
      users.each do |u|
        csv << [u.name,u.description,u.facility_id,u.created_on,u.updated_on]
      end
    end
  end

  private
    def stream_csv
       filename = params[:action] + ".csv"    
       #this is required if you want this to work with IE        
       if request.env['HTTP_USER_AGENT'] =~ /msie/i
         headers['Pragma'] = 'public'
         headers["Content-type"] = "text/plain" 
         headers['Cache-Control'] = 'no-cache, must-revalidate, post-check=0, pre-check=0'
         headers['Content-Disposition'] = "attachment; filename=\"#{filename}\"" 
         headers['Expires'] = "0" 
       else
         headers["Content-Type"] ||= 'text/csv'
         headers["Content-Disposition"] = "attachment; filename=\"#{filename}\"" 
       end

      render :text => Proc.new { |response, output|
        csv = FasterCSV.new(output, :row_sep => "\r\n") 
        yield csv
      }
    end
    
end
