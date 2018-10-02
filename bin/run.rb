require_relative '../config/environment'

# u1 = User.new()
# u1.name = "Bill"
# u1.save
#
# s1 = Stock.new()
# s1.name = "Apple"
# s1.ticker = "AAPL"
# s1.save
#
# t1 = Transaction.new()
# t1.user_id = u1.id
# t1.stock_id = s1.id
# t1.save

def seed_tickers_and_companies

  returned_array = Csv_parser.parse

  returned_array.each do |exchange_array|
    exchange_array.each do |company|
      temp = Stock.new
      temp.name = company[:company_name]
      temp.ticker = company[:ticker]
      temp.save
    end
  end

end




puts "Type seed if you wish to seed the database otherwise, press enter"
input =  gets.chomp

if input == "seed"
  seed_tickers_and_companies
end






binding.pry

0
