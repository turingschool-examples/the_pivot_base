module ApplicationHelper

  def login_tags(options = {})
    raw("#{link_to("Login", login_path, options)}<br/>\n#{link_to("Create new account", new_user_path, options)}")
  end

  def user_name_possessive
    if current_user
      current_user.first_name + "'s"
    else
      "Your"
    end
  end

  def admin_edit_tag(options)
    if current_user && current_user.authorized?
      link_to "Edit", edit_admin_store_item_path(store_slug: options[:store].slug, id: options[:item].id, class: options[:class])
    end
  end

end
