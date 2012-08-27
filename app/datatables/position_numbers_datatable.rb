class PositionNumbersDatatable
  delegate :params, :h, :raw, :link_to, :position_number_path, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: PositionNumber.count,
      iTotalDisplayRecords: position_numbers.total_count,
      aaData: data
    }
  end

private

  def data
    position_numbers.map do |position_number|
      [
        h(link_to(position_number.position_num, position_number)),
        position_number.position_title,
        position_number.position_type_name,
        position_number.waiver_approval_date,
        h(link_to 'Edit', position_number_path(position_number))
      ]
    end
  end

  def position_numbers
    @position_numbers ||= fetch_position_numbers
  end

  def fetch_position_numbers
    position_numbers = PositionNumber.includes([:position, :position_type]).order("#{sort_column} #{sort_direction}")
    position_numbers = position_numbers.page(page_count).per(per_page)
    if params[:sSearch].present?
      q = params[:sSearch]
      position_numbers = position_numbers.where("position_numbers.position_number like :search or position_type.name like :search", search: "%#{q}%")
    end
    position_numbers
  end

  def page_count
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[position_num position_type_name position_title waiver_approval_date]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
