class User < ActiveRecord::Base

  has_many :transactions
  has_many :stocks, through: :transactions

  # def initialize(name,cash_balance)
  #   @name = name
  #   @cash_balance = cash_balance
  # end

  def get_all_tickers_ever_transacted
    self.transactions.map do |transaction|
    transaction.ticker
    end.uniq
  end

  def purchase_stock_by_ticker(ticker,number_of_shares)
    #TODO, EXTRAS Ask user if wants to buy x amount if not enough money for initial requested purchase
    #TODO, EXTRAS Allow the user to buy the max amount of shares given a cash amount

    stock = Stock.find_by(ticker: ticker)
    price = stock.current_price
    transaction_cost = price * number_of_shares
    if transaction_cost > self.cash_balance
      puts "You do not have enough money to make this trade."
      nil
    else
      transaction = Transaction.create_transaction(self,stock,number_of_shares,"buy")
      transaction.price = stock.current_price
      transaction.save
      self.cash_balance -= transaction_cost
      self.save
      self.transactions << transaction
      puts "Your purchase cost was $#{transaction_cost}."
      transaction
    end
  end

  def sell_stock_by_ticker(ticker,number_of_shares)

    stock = Stock.find_by(ticker: ticker)
    price = stock.current_price
    transaction_proceeds = price * number_of_shares

    if number_of_shares > currently_owned_stocks[ticker]
      puts "You do not have enough shares to make this trade."
      nil
    else
      transaction = Transaction.create_transaction(self,stock,number_of_shares,"sell")
      transaction.price = stock.current_price
      transaction.save
      self.cash_balance += transaction_proceeds
      self.save
      self.transactions << transaction
      puts "Your account has been credited $#{transaction_proceeds}."
      transaction

    end

  end

  def currently_owned_stocks
      all_transactions = self.transactions
      owned_stocks = {}
      all_transactions.each do |transaction|

        if transaction.order_type == "buy"
          if owned_stocks[transaction.ticker] == nil
            owned_stocks[transaction.ticker] = transaction.num_shares
          else
            owned_stocks[transaction.ticker] += transaction.num_shares
          end
        elsif transaction.order_type == "sell"
          if owned_stocks[transaction.ticker] == nil
            ##TODO DOES our .transactions return in order? If so, we should never hit this code
            owned_stocks[transaction.ticker] = transaction.num_shares
          else
            owned_stocks[transaction.ticker] -= transaction.num_shares
          end
        end

      end #end of each
      owned_stocks
  end #end of method

  def current_stock_holdings_value
    self.currently_owned_stocks.map do |k, v|
      {ticker: k, shares: v, value: (v * Stock.find_by_ticker(k).current_price)}
    end
  end

  def portfolio_value
    self.current_stock_holdings_value.collect do |hash|
      hash[:value]
    end.sum + self.cash_balance
  end


end# end of User class
