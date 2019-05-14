require 'json'

class Account

	def initialize(name, currency, balance, transactions)
		@name = name
		@currency = currency
		@balance = balance
		@transactions = transactions
	end

	
	def to_json(*a)
    {
      "json_class" => self.class.name,
      "data"       => {"name" => @name, "currency" => @currency, "balance" => @balance, "transactions" => @transactions}
    }.to_json(*a)
  end


def self.json_create(o)
    new(o["data"]["name"], o["data"]["currency"], o["data"]["balance"], o["data"]["transactions"])
  end

end