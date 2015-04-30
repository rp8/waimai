# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def customer_name(customer)
    phone = customer.phone
    "(#{phone[0..2]}) #{phone[3..5]}-#{phone[6..-1]}" + ' - ' + customer.name + ', ' + customer.address
  end

  def link_to_directions(customer, options = {} )
    "<a href=\"#\" class=\"#{options[:class]}\" onclick=\"javascript:gmap_setDirections('2002 N. Fry Road Suite 116,Houston,TX 77084','#{customer.address}','en-US');return false;\">Directions</a>"
  end

  def link_to_map(canvas, address, options = {})
    "<a href=\"#\" class=\"#{options[:class]}\" onclick=\"javascript:showmap('#{canvas}', '#{address}');\">Map</a>"
  end

  def link_to_lb_close
    "<a href=\"#\" class=\"lbAction\" rel=\"deactivate\">Close</a>"
  end

  def label2_tag(name)
    "<label>#{name}</label>"
  end

  def data_tag(data)
    "<label class=\"data\">#{data}</label>"
  end

end
