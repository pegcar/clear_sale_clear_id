require 'spec_helper'

module ClearSaleClearId
  describe Order do
    describe 'when built from a hash' do
      let(:order) { build(:order, :malicious) }

      it 'can be build from a hash' do
        expect(order.instalments).to eq(1)
      end

      %w[
        id items total_amount instalments created_at delivery_days origin
        status channel_id b2b_or_b2c
      ].each do |element|
        it "has '#{element}' attribute" do
          expect(order.send(element)).to_not be_nil
        end
      end

      describe '#b2b_or_b2c' do
        describe 'when its B2B' do
          let(:order) { build(:order, :malicious, b2b_or_b2c: 'B2B') }

          it 'returns B2B' do
            expect(order.b2b_or_b2c).to eq('B2B')
          end
        end

        describe 'when its B2C' do
          let(:order) { build(:order, :malicious, b2b_or_b2c: 'B2C') }

          it 'returns B2C' do
            expect(order.b2b_or_b2c).to eq('B2C')
          end
        end

        describe 'when its other value' do
          let(:order) { build(:order, :malicious, b2b_or_b2c: 'foo') }

          it 'raises an ArgumentError' do
            expect { order }.to raise_error(ArgumentError)
          end
        end
      end

      describe '#items_count' do
        it 'has the number of items on the order' do
          expect(order.items_count).to eq(2)
        end

        describe 'when there is 2 items' do
          let(:order) { build(:order, :malicious, items: [1,2]) }

          it 'is 2' do
            expect(order.items_count).to eq(2)
          end
        end
      end

      describe '#items_price' do
        let(:order) do
          build(
            :order, items: [
              OrderItem.new(price: 10), OrderItem.new(price: 20)
            ]
          )
        end

        it 'has the total price for the items' do
          expect(order.items_price).to eq(30)
        end
      end
    end
  end
end
