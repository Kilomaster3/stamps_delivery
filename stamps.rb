require 'pry'

module StampsDelivery
  class WarmUpLevel
    ONEPENNY = 'однокопеечных марок'.freeze
    TWOPENNY = 'двухкопеечных марок'.freeze

    def sum_of_delivery(price)
      if price == 1
        return { first: 1, second: 0 }
      elsif price.even?
        return { first: 0, second: price / 2 }
      end

      { first: 1, second: price / 2 }
    end
  end

  class FirstLevel
    THREEPENNY = 'трехкопеечных марок'.freeze
    FIVEPENNY = 'пятикопеечных марок'.freeze

    def sum_of_delivery(price)
      price = price.to_i
      f_count = price / 5
      f_remain = price % 5
      t_count = f_remain / 3
      t_remain = f_remain % 3
      f_count -= t_remain
      t_count += t_remain * 2
      { first: t_count, second: f_count }
    end
  end

  class CalculatingDelivery
    def initialize(price, stamp_price)
      @price = price
      @stamp_price = stamp_price
    end

    def run
      @stamp_price.sum_of_delivery(@price)
    end
  end

  class ResultMessage
    def message(stamps_value, first_value, second_value)
      "#{stamps_value[:first]} #{first_value} и #{stamps_value[:second]} #{second_value}"
    end
  end

  class Program
    def initialize(count, stamp_price, message_builder)
      @count = count
      @stamp_price = stamp_price
      @message_builder = message_builder
    end

    def run_for_warm_up_level
      calculating_delivery = CalculatingDelivery.new(@count, @stamp_price)
      p @message_builder.message(calculating_delivery.run, WarmUpLevel::ONEPENNY, WarmUpLevel::TWOPENNY)
    end

    def run_for_first_level
      calculating_delivery = CalculatingDelivery.new(@count, @stamp_price)
      p @message_builder.message(calculating_delivery.run, FirstLevel::THREEPENNY, FirstLevel::FIVEPENNY)
    end
  end
end

pr = StampsDelivery::Program.new(ARGV[0].to_i, StampsDelivery::FirstLevel.new, StampsDelivery::ResultMessage.new)
pr.run_for_first_level