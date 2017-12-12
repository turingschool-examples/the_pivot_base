module ApplicationHelper

  def login_tags(options = {})
    raw("#{link_to("Login", login_path, options)}<br/>\n#{link_to("Create new account", new_user_path, options)}")
  end

end
