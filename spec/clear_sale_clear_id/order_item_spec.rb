require 'spec_helper'

module ClearSaleClearId
  describe OrderItem do
    let(:order_item) { build(:order_item) }

    %w[id description price quantity category_id category].each do |element|
      it "has '#{element}' attribute" do
        expect(order_item.send(element)).to_not be_nil
      end
    end
  end
end
