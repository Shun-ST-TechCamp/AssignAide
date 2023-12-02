module WorkdaysHelper
  def toggle_sort_direction(date, column)
    current_sort_direction = params[:sort_for_date] == date.to_s && params[:sort_column_for_date] == column ? params[:sort_direction_for_date] : nil
    current_sort_direction == "asc" ? "desc" : "asc"
  end
end