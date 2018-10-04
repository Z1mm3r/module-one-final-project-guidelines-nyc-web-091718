
class Admin_cli

  attr_reader :password

  def initialize
    #@password = 12345password
  end

  def admin_main
    puts "Welcome admin"
    loop do

      puts "(ADMIN) Main Menu: What would you like to do? (type h for a list of commands)"
      input = gets.chomp.downcase

      case input
      when "h"
        print_commands
      when "modify users"
          edit_users_menu
      end

    end
  end

  def edit_users_menu
    user = 0
    puts "(ADMIN) User Search Menu: Would you like to search by user's [id] or by user's [name]?"
    input = gets.chomp.downcase

    case input
    when "id"
      user = search_by_id
    when "name"
      user = search_by_name
    end

    puts "What would you like to do to user? [change name] [change balance] [view transactions]"
    input = gets.chomp.downcase

    case input
    when "change name"
      change_user_name(user)
    when "change balance"
      change_user_balance(user)
    when "view transactions"
      view_user_transactions(user)
    end

  end

  def change_user_name(user)
    puts "What would you like to change the name to?"
    input = gets.chomp
    user.name = input
    user.save
  end

  def change_user_balance(user)
    puts "What amount would you like to set the balance to?"
    input = gets.chomp
    user.cash_balance = input.to_f
    user.save
  end

  def view_user_transactions(user)
    user.transactions.each do |transaction|
      puts "Transaction ID : #{transaction.id}, User id #{transaction.user_id}, stock id #{transaction.stock_id}, price of stock #{transaction.price}, amount in transaction #{transaction.num_shares}, and type is #{transaction.order_type}"
    end
  end

  def search_by_name
    puts "Please Enter name (case sensitive)."
    input = gets.chomp
    User.find_by_name(input)
  end

  def search_by_id
    puts "Please Enter id number"
    input = gets.chomp
    User.find_by_id(input.to_i)
  end

  def print_commands
    puts "'Modify Users' - Allows you to edit user information based on an ID or Name "
    #{}"'View Transations - Allows you to view any transaction by id, stock_id, or user_id'"
  end

end
