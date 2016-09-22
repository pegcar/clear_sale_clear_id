module ClearSaleClearId
  module Response
    class PackageStatus
      attr_accessor :transaction_id, :status_code, :message, :orders
      attr_reader :request_body, :response_body


      def initialize(request_body, response_body)
        @response_body = response_body
        @request_body = request_body

        clear_id = Nori.new.parse(response_body)
        attributes = clear_id['ClearID']['PackageStatus']

        self.status_code = attributes['StatusCode'].to_i
        self.transaction_id = attributes['TransactionID']
        self.message = attributes['Message']

        self.orders = build_orders(attributes.fetch('Pedidos', []))
      end

      private

      def build_orders(orders_attributes)
        orders_attributes.map do |_, order_attribute|
          Order.new(orders_attributes)
        end
      end
    end
  end
end
