class EmployeePositionHistoriesDatatable
  delegate :params, :h, :raw, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: EmployeePositionHistory.count,
      iTotalDisplayRecords: histories.size,
      aaData: data
    }
  end

private

  def data
    histories.map do |history|
      [
        history.position_name,
        history.employee_name,
        #link_to(history.name, history),
        h(number_to_currency(history.salary)),
      ]
    end
  end

  def histories
    @histories ||= fetch_histories
  end

  def fetch_histories
    histories = EmployeePositionHistory.order_by("#{sort_column} #{sort_direction}")
    histories = histories.page(page_count).per(per_page)
    if params[:sSearch].present?
      q = params[:sSearch]
      histories = histories.where({search_terms: q.split.map{|x| /.*#{x}.*/} })
    end
    histories
  end

  def page_count
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name margin_max image_urls stay_count]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end

  def detailed(history)
    html = []
    html << link_to(history.name, history)
    html << history.street
    html << "#{[history.city,history.state].join(', ')} #{history.postal_code}"
    html << history.chain_code
    html.join("<br/>")
  end

  def margin_details(object)
    html = []
    object.margins.each do |margin|
      html << "#{margin.tier} - #{margin.percentage}%" 
    end
    h(html.join("<br/>"))
  end
end
