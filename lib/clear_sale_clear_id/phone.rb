module ClearSaleClearId
  class Phone < Struct.new(
    :type, :ddi, :ddd, :number, :branch
  )

    def type=(value)
      validate_type(value)

      self[:type] = value
    end

    private

    def validate_type(value)
      unless ['1', '0'].include?(value.to_s)
        raise ArgumentError.new("Value #{value} not valid for type!")
      end
    end
  end
end
