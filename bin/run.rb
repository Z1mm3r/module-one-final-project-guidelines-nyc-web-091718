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

def seed_users
    10.times do
      user = User.new
      user.name = Faker::Name.name
      user.cash_balance = rand(100000).to_f
      user.save
    end
end

def seed_buy_transactions

  number_of_stocks = Stock.all.count
    User.all.each do |user|
      10.times do
        user.purchase_stock_by_ticker(Stock.find(rand(number_of_stocks)).ticker,rand(15))
      end
    end

end


def seed_sell_transactions
  User.all.each do |user|
      stocks_to_sell = user.currently_owned_stocks.to_a.sample(3).to_h

      stocks_to_sell.each do |k,v|
        user.sell_stock_by_ticker(k,rand(v))
      end
  end
end


# puts "Type seed if you wish to seed the database otherwise, press enter"
# input =  gets.chomp
#
# if input == "seed"
#   seed_tickers_and_companies
#   seed_users
#   seed_buy_transactions
#   seed_sell_transactions
# end


admin_cli = Admin_cli.new

user_cli  = User_cli.new

puts "would you like to log in as an [admin] or [user]?"
input = gets.chomp.downcase

if(input == "admin")
  admin_cli.admin_main
elsif(input == "user")
  user_cli.user_main
end



binding.pry

0
