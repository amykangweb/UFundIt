ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails/capybara'
require 'minitest/pride'
require 'minitest/reporters'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers
end

def sign_in(name = :user)
  visit root_path
  click_link('Log in')
  fill_in 'Email', with: users(name).email
  fill_in 'Password', with: 'password'
  click_button('Log in')
end

# to generate a new test:
# rails generate minitest:feature articles/CreatingArticles --spec

# to just run one test:
# RAILS_ENV=test ruby -Itest test/controller/no_haxzors_test.rb
# must comment out 'Rails.env = "test"' first
