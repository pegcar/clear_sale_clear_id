module ClearSaleClearId
  class OrderItem < Struct.new(
    :id, :description, :price, :quantity, :category_id, :category, :obs
  )
    def initialize(params={})
      members.each {|member| self[member] ||= params.delete(member)}
    end
  end
end
