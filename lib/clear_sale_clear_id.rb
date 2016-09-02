env=ENV.fetch('RACK_ENV', 'development')
unless env == 'production'
  require 'dotenv'
  Dotenv.load ".env.#{env}"
end

require 'clear_sale_clear_id/version'
require 'clear_sale_clear_id/order_item'
require 'clear_sale_clear_id/order_xml'
require 'clear_sale_clear_id/order'
require 'clear_sale_clear_id/address'
require 'clear_sale_clear_id/user'
require 'clear_sale_clear_id/phone'
require 'clear_sale_clear_id/payment'
require 'clear_sale_clear_id/server'
require 'clear_sale_clear_id/response'

require 'builder'

module ClearSaleClearId
end
