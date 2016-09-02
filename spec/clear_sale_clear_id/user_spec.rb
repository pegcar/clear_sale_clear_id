require 'spec_helper'

module ClearSaleClearId
  describe User do
    describe '#birthdate' do
      let(:user) { build(:user, birthdate: '09/04/1987') }

      it 'parses the date' do
        expect(user.birthdate.class).to eq(Date)
      end
    end

    describe '#gender' do
      describe 'when its M' do
        let(:user) { build(:user, gender: 'M') }

        it 'returns M' do
          expect(user.gender).to eq('M')
        end
      end

      describe 'when its F' do
        let(:user) { build(:user, gender: 'F') }

        it 'returns F' do
          expect(user.gender).to eq('F')
        end
      end

      describe 'when its other value' do
        let(:user) { build(:user, gender: 'foo') }

        it 'raises an ArgumentError' do
          expect { user }.to raise_error(ArgumentError)
        end
      end
    end
  end
end
