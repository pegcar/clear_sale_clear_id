$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
ENV['RACK_ENV'] = 'test'

require './spec/support/factory_girl'


require 'rspec/matchers'
require 'nokogiri'
require 'equivalent-xml'
require 'pry-nav'

require 'webmock'
require 'vcr'
require 'savon'
require 'clear_sale_clear_id'

RSpec.configure do |config|
  config.before(:each) do
    env=ENV.fetch('RACK_ENV', 'development')
    unless env == 'production'
      require 'dotenv'
      Dotenv.load ".env.#{env}"
    end
  end
end

VCR.config do |config|
  config.cassette_library_dir = File.expand_path(
    '../../spec/support/vcr_cassettes', __FILE__
  )
  config.stub_with :webmock
  config.allow_http_connections_when_no_cassette = false
  config.default_cassette_options = {
    record: :new_episodes,
    match_requests_on: [:uri, :body, :method]
  }
  config.before_record do |i|
    i.response.body.force_encoding('UTF-8')
  end
end
