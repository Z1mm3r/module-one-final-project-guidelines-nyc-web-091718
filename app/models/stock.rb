class Stock < ActiveRecord::Base

  has_many :transactions
  has_many :users, through: :transactions

  def current_price
    self.detailed_info['latestPrice']
  end

  def detailed_info
    response = RestClient.get "https://api.iextrading.com/1.0/stock/#{self.ticker}/quote"
    respons_par = JSON.parse(response)
  end

end
