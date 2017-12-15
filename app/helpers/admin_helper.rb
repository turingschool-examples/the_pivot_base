module AdminHelper

  def cancel_tag(order)
    if order.status == "paid" || order.status == "ordered"
      link_to("Cancel",
              order_path(order, status: "cancelled"),
              method: :put,
              class: "badge badge-warning")
    end
  end

  def change_status_tag(order)
    status ||= "paid" if order.status == "ordered"
    status ||= "completed" if order.status == "paid"
    if status
      link_to("Mark as #{status.capitalize}",
              order_path(order, status: status),
              method: :put,
              class: "badge badge-success")
    end
  end

end
