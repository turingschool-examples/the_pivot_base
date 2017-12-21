SimpleCov.start "rails" do
  add_filter "app/channels/application_cable/channel.rb"
  add_filter "app/channels/application_cable/connection.rb"
  add_filter "app/models/application_record.rb"
  add_filter "/app/jobs/*"
  add_filter "/app/mailers/*"
end
