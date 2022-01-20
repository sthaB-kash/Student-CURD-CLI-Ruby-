# require './welcome.rb'

require_relative 'database_connection'
require_relative 'actions'


class Student

  attr_accessor :choice, :con

  def initialize
    @choice = 0
    @con = Connection.new.con
    display_menu
  end

  def close
    @con.close()
    puts "close db connection"
  end

  private

  def display_menu
    begin
      puts "*" * 20
      puts "1. List all"
      puts "2. View Details"
      puts "3. Insert"
      puts "4. Update"
      puts "5. Delete"
      puts "6. Exit"
      print "Enter your choice: "
      get_choice
    end while (@choice != 6)
    
  end
  
  def get_choice
    @choice = gets.chomp.to_i
    puts "choice #{@choice}"
    system("clear")
    case(@choice)
      when 1
        Actions.list_students(@con)
      when 2
        Actions.view_details(@con)
      when 3
        Actions.insert_student(@con)
      when 4
        Actions.update_student(@con)
      when 5 
        Actions.delete_student(@con)
      when 6
        close()
        puts "Thank you..."
      else
        puts "please select a valid option"
    end
  end

end

std = Student.new


END {
  std.close();
}