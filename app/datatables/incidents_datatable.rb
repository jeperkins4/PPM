class IncidentsDatatable
  delegate :params, :h, :raw, :link_to, :incident_path, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Incident.count,
      iTotalDisplayRecords: incidents.total_count,
      aaData: data
    }
  end

private

  def data
    incidents.map do |incident|
      [
        h(link_to(incident.mins, incident)),
        incident.incident_on,
        incident.days_open,
        incident.incident_type_name,
        incident.contract_manager_notified_on,
        incident.action_type_name,
        h(link_to 'Edit', incident_path(incident))
      ]
    end
  end

  def incidents
    @incidents ||= fetch_incidents
  end

  def fetch_incidents
    incidents = Incident.includes([:action_type, :incident_type]).select('incident_types.name as incident_type_name, incidents.mins, incidents.incident_on, incidents.days_open, incidents.contract_manager_notified, :action_types.name as action_types_name').order("#{sort_column} #{sort_direction}")
    incidents = incidents.page(page_count).per(per_page)
    if params[:sSearch].present?
      q = params[:sSearch]
      incidents = incidents.where("incidents.mins like :search or incident_type.name like :search", search: "%#{q}%")
    end
    incidents
  end

  def page_count
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[mins incident_on days_open incident_type_name contract_manager_notified_on action_type_name]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
