module ClearSaleClearId
  class Address < Struct.new(
    :street, :street1, :number, :neighborhood, :city, :state, :zipcode, :country
  )
  end
end
