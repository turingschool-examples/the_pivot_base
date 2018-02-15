require 'spec_helper'
require 'simplecov'
SimpleCov.start 'rails'


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


VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.filter_sensitive_data("some_place_holder_string_to_appear_in_your_cassette") {ENV['GITHUB_USER_TOKEN']}
  # =>                         make up a string that will be in the cassette.         this is the sensitive value that we DON'T want to apear
  config.allow_http_connections_when_no_cassette = true
end


ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include SantasLittleHelper
  config.include FeatureHelper

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!


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

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
