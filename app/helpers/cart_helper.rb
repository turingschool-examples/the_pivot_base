module CartHelper
  include ApplicationHelper

  def checkout_tag(options = {})
    if current_user
      link_to("Checkout", new_order_path, options)
    else
      login_tags(options)
    end
  end

end
