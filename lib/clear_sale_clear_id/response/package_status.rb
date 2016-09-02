module ClearSaleClearId
  module Response
    class PackageStatus
      attr_accessor :transaction_id, :status_code, :message, :orders

      def initialize(xml = nil)
        clear_id = Nori.new.parse(xml)
        attributes = clear_id['ClearID']['PackageStatus']

        self.transaction_id = attributes['TransactionID']
        self.status_code = attributes['StatusCode']
        self.message = attributes['Message']
        self.orders = build_orders(attributes['Pedidos'])
      end

      private

      def build_orders(orders_attributes)
        orders_attributes.map do |order_attribute|
          Order.new(orders_attributes)
        end
      end
    end
  end
end
