
class User_cli

  attr_reader :user

  def user_main
    self.welcome_message
    self.login

    loop do

      puts "Main Menu: What would you like to do? (type h for a list of commands)"
      input = gets.chomp.downcase

      case input
      when "end"
        break
      when "h"
        print_commands
      when "cash"
        display_cash
      when "portfolio"
        display_portfolio_value
      when "stock value"
        display_current_value_of_stock_holdings
      when "stock"
        display_stocks
      when "sell"
        sell_screen
      when "purchase"
        buy_screen
      end

    end

    puts "Goodbye."

  end

  def print_commands
    puts " 'portfolio' - returns the current value of your holdings, including your cash balance"
    puts " 'Stock Value' - returns each of your stock positions and its value."
    puts " 'Stock' - returns stocks currently held, and the amount you own."
    puts " 'purchase' - brings you to the purchase screen"
    puts " 'sell' - brings you to the sell screen"
    puts " 'cash' - displays current value of cash holding."
    puts " 'end' - logs out of account"

  end

  def buy_screen

    puts "Buying Menu:"
    puts "type 'h' for commands "

    loop do
      puts "(Buying Menu) What would you like to do?"
      input = gets.chomp
      case input
      when "h"
        print_buy_commands
      when "exit"
        break
      when "peek"
        peek
      when "cash"
        display_cash
      when "stock"
        display_stocks
      when "detail"
        detail
      when "buy stock"
        buy_stock
      end
    end# end of loop do

  end

  def sell_screen
    puts "Selling Menu:"
    puts "type 'h' for commands "

    loop do
      puts "(Selling Menu) What would you like to do?"
      input = gets.chomp
      case input
      when "h"
        print_sell_commands
      when "exit"
        break
      when "peek"
        peek
      when "cash"
        display_cash
      when "stock"
        display_stocks
      when "detail"
        detail
      when "sell stock"
        sell_stock
      end
    end# end of loop do
  end

  def print_buy_commands
    puts "'peek' shows company name and current price."
    puts "'detail' shows company name, its sector, the current price and the high and low price of the day. "
    puts "'Buy Stock' request a purchase of x amount of stock at market price."
    puts "'Stock' - returns stocks currently held, and the amount you own."
    puts "'cash' - displays current value of cash holding."
    puts "'exit' - returns you to the main menu."
  end

  def print_sell_commands
      puts "'peek' shows company name and current price."
      puts "'detail' shows company name, its sector, the current price and the high and low price of the day. "
      puts "'Sell Stock' request a purchase of x amount of stock at market price."
      puts "'Stock' - returns stocks currently held, and the amount you own."
      puts "'cash' - displays current value of cash holding."
      puts "'exit' - returns you to the main menu."
  end

  def buy_stock
    display_cash
    puts "What stock (by ticker) would you like to buy?"
    inputTicker = gets.chomp.upcase
    puts "How many shares would you like to buy?"
    inputShares = gets.chomp.to_i
    self.user.purchase_stock_by_ticker(inputTicker,inputShares)

  end

  def sell_stock
    display_stocks

    puts "What stock (by ticker) would you like to sell?"
    inputTicker = gets.chomp.upcase
    puts "How many shares would you like to sell?"
    inputShares =gets.chomp.to_i
    self.user.sell_stock_by_ticker(inputTicker,inputShares)

  end

  def detail
    puts "What stock would you like to take a deeper look at?"
    input = gets.chomp
    input.upcase!
    info = Stock.find_by_ticker(input).detailed_info
    puts "#{info["companyName"]} (#{info["symbol"]}) Sector: [#{info["sector"]}] trading at $#{User_cli.float_to_cash(info["latestPrice"])}. Today's high: #{float_to_cash(info["high"])}. Today's low: #{float_to_cash(info["low"])}."
  end

  def peek()
    puts "What stock would you like to peek at?"
    input = gets.chomp
    input.upcase!
    info = Stock.find_by_ticker(input).detailed_info
    puts "#{info["companyName"]} (#{info["symbol"]}) trading at $#{User_cli.float_to_cash(info["latestPrice"])}."
  end

  def display_stocks
    self.user.currently_owned_stocks.each do |k,v|
      puts "#{v} share(s) of #{k}."
    end
  end

  def display_current_value_of_stock_holdings
    self.user.current_stock_holdings_value.each do |hash|
      puts "You have #{hash[:shares]} share(s) of #{hash[:ticker]} worth a total of $#{User_cli.float_to_cash(hash[:value])}."
    end
  end

  def display_portfolio_value
    puts "Current total value of cash and stock positions is $#{User_cli.float_to_cash(self.user.portfolio_value)}."
  end

  def display_cash
    money = self.user.cash_balance
    puts ("Current free cash is $#{User_cli.float_to_cash(money)}")
    #money = Money.new(self.user.cash_balance, "USD")
    #money = Money.new(1000, "USD")
    #binding.pry
    #puts money.currency.to_s
    #binding.pry
  end

  def self.float_to_cash(float)
      money = float.to_s.split(".")
      until money.length > 1
        money << "0"
      end
      "#{money[0]}.#{money[1][0,2]}"
  end

  def welcome_message
    puts "Welcome to Zimzalez Trading!"
  end

  def login
    has_logged_in = false

    until has_logged_in
      puts "Please enter your account number."
      input = gets.chomp

      if(User.find_by_id(input.to_i) != nil)
        has_logged_in = true
        @user = User.find(input.to_i)
        puts "Welcome back #{user.name}."

      elsif input == "exit"
        break
      else
        puts "Incorrect account information given."
      end
    end
  end

end #end user_cli class
