module MoneyColumn
  module StoresMoney
    def self.included(klass)
      klass.send(:extend, ClassMethods)
    end

    module ClassMethods
      def stores_money(money_name, options = {})
        options =
          {
            :cents_attribute => "#{money_name}_in_cents",
            :allow_nil => true
          }.merge(options)

        class_eval <<-EOV
          def #{money_name}
            cents = send('#{options[:cents_attribute]}')

            if !#{options[:allow_nil]}
              cents ||= 0
            end

            if cents.to_s.empty?
              nil
            else
              Money.new(cents, money_currency)
            end
          end

          def #{money_name}=(amount)
            self.#{options[:cents_attribute]} = if amount.to_s.empty?
              nil
            else
              amount.to_money(money_currency).cents
            end
          end

          def money_currency
            self.respond_to?(:currency) && !self.currency.nil? ? currency : ::Money.default_currency
          end
        EOV
      end
    end
  end
end
