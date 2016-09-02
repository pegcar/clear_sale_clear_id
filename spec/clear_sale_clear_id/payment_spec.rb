require 'spec_helper'

module ClearSaleClearId
  describe Payment do
    describe '#type' do
      describe 'when its 0' do
        let(:payment) { build(:payment, type: '0') }

        it 'raises an ArgumentError' do
          expect { payment }.to raise_error(ArgumentError)
        end
      end

      describe 'when its 1' do
        let(:payment) { build(:payment, type: '1') }

        it 'returns 1' do
          expect(payment.type).to eq('1')
        end
      end

      describe 'when its 14' do
        let(:payment) { build(:payment, type: '14') }

        it 'returns 14' do
          expect(payment.type).to eq('14')
        end
      end

      describe 'when its 15' do
        let(:payment) { build(:payment, type: '15') }

        it 'raises an ArgumentError' do
          expect { payment }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
