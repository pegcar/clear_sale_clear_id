module ClearSaleClearId
  class User < Struct.new(
    :id, :type, :document, :document1, :name, :email, :gender, :birthdate,
    :addresses, :phones, :ip, :session_id
  )

    def initialize(params={})
      params.keys.each do |member|
        self.send("#{member}=", params.delete(member))
      end
    end

    def gender=(value)
      validate_gender(value)

      self[:gender] = value
    end

    def birthdate
      Date.parse self[:birthdate]
    end

    private

    def validate_gender(value)
      unless ['M', 'F'].include?(value)
        raise ArgumentError.new("Value #{value} not valid for gender!")
      end
    end
  end
end
