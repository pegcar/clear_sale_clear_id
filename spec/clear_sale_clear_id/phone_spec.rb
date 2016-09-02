require 'spec_helper'

module ClearSaleClearId
  describe Phone do
    describe '#type' do
      describe 'when its 0' do
        let(:phone) { build(:phone, type: '0') }

        it 'returns 0' do
          expect(phone.type).to eq('0')
        end
      end

      describe 'when its 1' do
        let(:phone) { build(:phone, type: '1') }

        it 'returns 1' do
          expect(phone.type).to eq('1')
        end
      end

      describe 'when its other value' do
        let(:phone) { build(:phone, type: 'foo') }

        it 'raises an ArgumentError' do
          expect { phone }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
