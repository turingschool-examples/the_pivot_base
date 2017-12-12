module AdminHelper

  def cancel_tag(order)
    if order.status == "paid" || order.status == "ordered"
      link_to("Cancel",
              order_path(order, status: "cancelled"),
              method: :put,
              class: "badge badge-warning")
    end
  end

end
