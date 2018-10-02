class Stock < ActiveRecord::Base

  has_many :transactions
  has_many :users, through: :transactions

  def current_price

    response = RestClient.get "https://api.iextrading.com/1.0/stock/#{self.ticker}/quote"
    respons_par = JSON.parse(response)
    binding.pry
    respons_par['latestPrice']
  end


end
