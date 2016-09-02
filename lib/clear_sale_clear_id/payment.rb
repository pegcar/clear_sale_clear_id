module ClearSaleClearId
  class Payment < Struct.new(
    :sequential, :created_at, :amount, :type, :instalments, :credit_card_hash,
    :credit_card_bin, :credit_card_last_four, :credit_card_expiration,
    :credit_card_owner_name, :document, :credit_card_type
  )

    def initialize(params={})
      params.keys.each do |member|
        self.send("#{member}=", params.delete(member))
      end
    end

    def type=(value)
      validate_type(value)

      self[:type] = value
    end

    private

    def validate_type(value)
      unless (1..14).map(&:to_s).include?(value.to_s)
        raise ArgumentError.new("Value #{value} not valid for type!")
      end
    end


  end
end
