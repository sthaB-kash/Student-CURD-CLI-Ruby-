require 'pg'
# con  = PGconn.connect("localhost",5432,"","","postgres","postgres","")

class Connection
  attr_accessor :con
  def initialize
    begin
      @con = PG.connect :dbname => 'student_database', :user => 'bikash'
    rescue => exception
      puts exception.message
    ensure
      if @con
        puts "Connected to database"
      else
        puts "fail connect to database"
      end
    end
  end
end
