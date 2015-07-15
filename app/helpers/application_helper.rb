module ApplicationHelper
  def clean_time(time)
    time.strftime ("%b %e, %l:%M %p") 
  end
end
