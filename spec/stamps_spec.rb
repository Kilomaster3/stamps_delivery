require 'spec_helper'
require './stamps'

RSpec.describe StampsDelivery do
  describe 'WarmUpLevel class' do
    context 'when price 5' do
      it 'found price of delivery' do
        result = StampsDelivery::WarmUpLevel.new
        expect(result.sum_of_delivery(5)).to eq({ first: 1, second: 2 })
      end
    end

    context 'when price 15' do
      it 'found price of delivery' do
        result = StampsDelivery::WarmUpLevel.new
        expect(result.sum_of_delivery(15)).to eq({ first: 1, second: 7 })
      end
    end

    describe 'FirstLevel class' do
      context 'when price 111' do
        it 'found price of delivery' do
          result = StampsDelivery::FirstLevel.new
          expect(result.sum_of_delivery(111)).to eq({ first: 2, second: 21 })
        end
      end

      context 'when price 25' do
        it 'found price of delivery' do
          result = StampsDelivery::FirstLevel.new
          expect(result.sum_of_delivery(25)).to eq({ first: 0, second: 5 })
        end
      end
    end
  end
end