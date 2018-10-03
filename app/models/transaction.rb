class Transaction  < ActiveRecord::Base

  belongs_to :user
  belongs_to :stock

  def self.create_transaction(user,stock,num_shares,order_type)
    transaction = self.new
    transaction.user = user
    transaction.stock = stock
    transaction.num_shares = num_shares
    transaction.order_type = order_type
    transaction
  end

  def user= (value)
    self.user_id = value.id
  end

  def user
    User.find(self.user_id)
  end

  def stock= (stock)
    self.stock_id = stock.id
  end

  def stock
    Stock.find(stock_id)
  end

  def ticker
    Stock.find(stock_id).ticker
  end

  def company
    Stock.find(stock_id).name
  end

end
