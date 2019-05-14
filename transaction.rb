
require 'json'

class Transaction

	def initialize (name, balance, currency, description, date)
		@name = name
		@balance = balance
		@currency = currency
		@description = description
    @date = date
	end

	
  def to_json(*a)
    {
      "json_class" => self.class.name,
      "data"       => {"name" => @name, "currency" => @currency, "balance" => @balance, "description" => @description, "date" => @date}
    }.to_json(*a)
  end


def self.json_create(o)
    new(o["data"]["name"], o["data"]["currency"], o["data"]["balance"], o["data"]["description"], o["data"]["date"])

  end

end