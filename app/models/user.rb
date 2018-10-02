class User < ActiveRecord::Base

  has_many :transactions
  has_many :stocks, through: :transactions

  # def initialize(name,cash_balance)
  #   @name = name
  #   @cash_balance = cash_balance
  # end

end
