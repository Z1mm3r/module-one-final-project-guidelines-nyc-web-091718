require_relative '../config/environment'

class Csv_parser

  def self.parse

      temp = SmarterCSV.process('./lib/csv/nyse.csv')
      parsed_nyse = temp.map do |hash|
        {ticker: hash[:symbol], company_name: hash[:name]}
      end

      temp = SmarterCSV.process('./lib/csv/nasdaq.csv')
      parsed_nasdaq= temp.map do |hash|
        {ticker: hash[:symbol], company_name: hash[:name]}
      end


      [parsed_nyse,parsed_nasdaq]


  end

end
