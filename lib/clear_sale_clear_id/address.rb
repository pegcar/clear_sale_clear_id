module ClearSaleClearId
  class Address < Struct.new(
    :street, :street1, :number, :neighborhood, :city, :state, :zipcode, :country
  )

    def initialize(params={})
      params.keys.each do |member|
        self.send("#{member}=", params.delete(member))
      end
    end
  end
end
