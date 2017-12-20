require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'capybara/rails'
require 'database_cleaner'
require 'support/factory_girl'
require 'support/simple_cov'
require 'feature_helper'
require 'santas_little_helper'
require 'support/request_spec_helper.rb'


require "paperclip/matchers"

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include SantasLittleHelper
  config.include FeatureHelper
  config.include Paperclip::Shoulda::Matchers
  config.include RequestSpecHelper, type: :request

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.before(:each) do
    allow_any_instance_of(Paperclip::Attachment).to receive(:save).and_return(true)
  end

  # Required to be false for DatabaseCleaner config below
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
Capybara.server = :puma

Capybara.register_driver :selenium_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end
Capybara.javascript_driver = :selenium_chrome

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
