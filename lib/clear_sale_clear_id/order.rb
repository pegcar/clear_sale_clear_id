module ClearSaleClearId
  class Order < Struct.new(
    :id, :items, :total_amount, :instalments, :created_at, :delivery_days,
    :origin, :status, :observation, :channel_id, :b2b_or_b2c, :delivery_amount,
    :user, :address, :phones, :payments
  )
    STATUS_NEW = 0
    STATUS_APPROVED = 9
    STATUS_CANCELLED = 41
    STATUS_UNAPPROVED = 45

    STATUS = [STATUS_NEW, STATUS_APPROVED, STATUS_CANCELLED, STATUS_UNAPPROVED]

    include ::ClearSaleClearId::OrderXml

    def initialize(params={})
      params.merge!({ phones: []})
      params.keys.each do |member|
        self.send("#{member}=", params.delete(member))
      end
    end

    def items_count
      items.size
    end

    def items_price
      items.map(&:price).inject(&:+)
    end

    def b2b_or_b2c=(value)
      validate_b2b_or_b2c(value)

      self[:b2b_or_b2c] = value
    end

    private

    def validate_b2b_or_b2c(value)
      unless ['B2B', 'B2C'].include?(value)
        raise ArgumentError, "Value #{value} not valid for b2b_or_b2c!"
      end
    end
  end
end
