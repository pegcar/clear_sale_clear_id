require 'spec_helper'

module ClearSaleClearId
  describe Order do
    describe '#approved?' do
      describe 'when the response code is APA' do
        let(:order) { build(:order_response, :approved) }

        it 'returns true' do
          expect(order.approved?).to be_truthy
        end
      end

      describe 'when the response code is PAV' do
        let(:order) { build(:order_response, :needs_quiz) }

        it 'returns false' do
          expect(order.approved?).to be_falsy
        end
      end

      describe 'when the response code is APQ' do
        let(:order) { build(:order_response, :approved_by_quiz) }

        it 'returns true' do
          expect(order.approved?).to be_truthy
        end
      end

      describe 'when the response code is RPQ' do
        let(:order) { build(:order_response, :reproved_by_quiz) }

        it 'returns false' do
          expect(order.approved?).to be_falsy
        end
      end

      describe 'when the response code is RPP' do
        let(:order) { build(:order_response, :reproved_by_politic) }

        it 'returns false' do
          expect(order.approved?).to be_falsy
        end
      end

      describe 'when the response code is RPA' do
        let(:order) { build(:order_response, :reproved) }

        it 'returns false' do
          expect(order.approved?).to be_falsy
        end
      end

      describe 'when the response code is QNG' do
        let(:order) { build(:order_response, :quiz_not_generated) }

        it 'returns false' do
          expect(order.approved?).to be_falsy
        end
      end
    end

    describe '#reproved?' do
      describe 'when the response code is APA' do
        let(:order) { build(:order_response, :approved) }

        it 'returns false' do
          expect(order.reproved?).to be_falsy
        end
      end

      describe 'when the response code is PAV' do
        let(:order) { build(:order_response, :needs_quiz) }

        it 'returns false' do
          expect(order.reproved?).to be_falsy
        end
      end

      describe 'when the response code is APQ' do
        let(:order) { build(:order_response, :approved_by_quiz) }

        it 'returns false' do
          expect(order.reproved?).to be_falsy
        end
      end

      describe 'when the response code is RPQ' do
        let(:order) { build(:order_response, :reproved_by_quiz) }

        it 'returns true' do
          expect(order.reproved?).to be_truthy
        end
      end

      describe 'when the response code is RPP' do
        let(:order) { build(:order_response, :reproved_by_politic) }

        it 'returns true' do
          expect(order.reproved?).to be_truthy
        end
      end

      describe 'when the response code is RPA' do
        let(:order) { build(:order_response, :reproved) }

        it 'returns true' do
          expect(order.reproved?).to be_truthy
        end
      end

      describe 'when the response code is QNG' do
        let(:order) { build(:order_response, :quiz_not_generated) }

        it 'returns true' do
          expect(order.reproved?).to be_truthy
        end
      end
    end

    describe '#needs_quiz?' do
      describe 'when the response code is APA' do
        let(:order) { build(:order_response, :approved) }

        it 'returns false' do
          expect(order.needs_quiz?).to be_falsy
        end
      end

      describe 'when the response code is PAV' do
        let(:order) { build(:order_response, :needs_quiz) }

        it 'returns true' do
          expect(order.needs_quiz?).to be_truthy
        end
      end

      describe 'when the response code is APQ' do
        let(:order) { build(:order_response, :approved_by_quiz) }

        it 'returns false' do
          expect(order.needs_quiz?).to be_falsy
        end
      end

      describe 'when the response code is RPQ' do
        let(:order) { build(:order_response, :reproved_by_quiz) }

        it 'returns false' do
          expect(order.needs_quiz?).to be_falsy
        end
      end

      describe 'when the response code is RPP' do
        let(:order) { build(:order_response, :reproved_by_politic) }

        it 'returns false' do
          expect(order.needs_quiz?).to be_falsy
        end
      end

      describe 'when the response code is RPA' do
        let(:order) { build(:order_response, :reproved) }

        it 'returns false' do
          expect(order.needs_quiz?).to be_falsy
        end
      end

      describe 'when the response code is QNG' do
        let(:order) { build(:order_response, :quiz_not_generated) }

        it 'returns false' do
          expect(order.needs_quiz?).to be_falsy
        end
      end
    end

    describe '#new' do
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
