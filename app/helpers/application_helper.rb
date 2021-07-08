module ApplicationHelper
  def page_title
    if @page_title
      "#{@page_title}|MyFavotriteItems"
    else
      "MyFavotriteItems"
    end
  end
end
