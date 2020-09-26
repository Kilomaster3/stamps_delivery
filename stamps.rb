# frozen_string_literal: true

require 'pry'

module StampsDelivery
  ONEPENNY = 'однокопеечных марок'
  TWOPENNY = 'двухкопеечных марок'
  THREEPENNY = 'трехкопеечных марок'
  FIVEPENNY = 'пятикопеечных марок'

  class WarmUpLevel
    def sum_of_delivery(delivery_price)
      if delivery_price == 1
        return { one_cent_stamp_amount: 1, two_cent_stamp_amount: 0 }
      elsif delivery_price.even?
        return { one_cent_stamp_amount: 0, two_cent_stamp_amount: delivery_price / 2 }
      end

      { one_cent_stamp_amount: 1, two_cent_stamp_amount: delivery_price / 2 }
    end
  end


  class FirstLevel
    def sum_of_delivery(delivery_price)
      delivery_price = delivery_price.to_i
      f_count = delivery_price / 5
      f_remain = delivery_price % 5
      t_count = f_remain / 3
      t_remain = f_remain % 3
      f_count -= t_remain
      t_count += t_remain * 2
      { three_cent_stamp_amount: t_count, five_cent_stamp_amount: f_count }
    end
  end

  class CalculatingDelivery
    def initialize(delivery_price, stamp_price)
      @delivery_price = delivery_price
      @stamp_price = stamp_price
    end

    def run
      stamp_price.sum_of_delivery(delivery_price)
    end

    private

    attr_reader :delivery_price, :stamp_price
  end

  class ResultMessage
    def message_for_warm_up_level(stamps_value, first_value, second_value)
      "#{stamps_value[:one_cent_stamp_amount]} #{first_value} и #{stamps_value[:two_cent_stamp_amount]} #{second_value}"
    end

    def message_for_first_level(stamps_value, first_value, second_value)
     "#{stamps_value[:three_cent_stamp_amount]} #{first_value} и #{stamps_value[:five_cent_stamp_amount]} #{second_value}"
    end
  end

  class Program
    def initialize(count_price, stamp_price, message_builder)
      @count_price = count_price
      @stamp_price = stamp_price
      @message_builder = message_builder
    end

    def run_for_warm_up_level
      calculating_delivery = CalculatingDelivery.new(count_price, stamp_price)
      message_builder.message_for_warm_up_level(calculating_delivery.run, ONEPENNY, TWOPENNY)
    end

    def run_for_first_level
      calculating_delivery = CalculatingDelivery.new(count_price, stamp_price)
      message_builder.message_for_first_level(calculating_delivery.run, THREEPENNY, FIVEPENNY)
    end

    private

    attr_reader :count_price, :stamp_price, :message_builder
  end
end

pr = StampsDelivery::Program.new(ARGV[0].to_i, StampsDelivery::FirstLevel.new, StampsDelivery::ResultMessage.new)
p pr.run_for_first_level
