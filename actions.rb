module Actions
  def self.list_students(con)
    res = con.exec("select * from students")
    puts "*" * 40
    puts "SN\tID\t\tNAME"
    sn = 0
    res.each { |std|
      # puts s
      puts "#{sn+=1}.\t#{std['id']}\t\t#{std['name']}"      
    }
    puts "*" * 40
    readline
  end

  def self.insert_student(con)
    name, city, semester, program, faculty = get_details()

    # puts name, city, semester, program, faculty
    query = "INSERT INTO students(name, city, semester, program, faculty) values('#{name}', '#{city}', '#{semester}', '#{program}', '#{faculty}');"
    con.exec(query)
    puts "Record inserted successfully"
    readline
  end

  def self.view_details(con)
    system("clear")
    print "Enter Student ID: "
    sid = gets.chop.to_i
    query = "SELECT * FROM students where id=#{sid};"
    res = con.exec(query)
    puts "", "*" * 50
    puts "ID:\t\t#{res[0]['id']}"
    puts "Name:\t\t#{res[0]['name']}"
    puts "City:\t\t#{res[0]['city']}"
    puts "Semester:\t#{res[0]['semester']}"
    puts "Program:\t#{res[0]['program']}"
    puts "Faculty:\t#{res[0]['faculty']}"
    puts "*" * 50
    readline
  end

  def self.update_student(con)
    if sid = self.student_exist?(con)
      name, city, semester, program, faculty = self.get_details()
      query = "UPDATE students set name='#{name}', city='#{city}', program='#{program}', semester='#{semester}', faculty='#{faculty}' where id = #{sid};"
      res = con.exec(query)
      puts "Updated successfully"
    end
    readline
  end

  def self.delete_student(con)
    if sid = self.student_exist?(con)
      con.exec("DELETE FROM students where id=#{sid}")
      puts "Record Deleted Successfully."
    end
    readline
  end

  def self.get_details
    system("clear")
    print "Enter the following details:\n"
    print "Name: "
    name = gets.chomp
    print "City: "
    city = gets.chomp
    print "Semester: "
    semester = gets.chomp
    print "Program: "
    program = gets.chomp
    print "Faculty: "
    faculty = gets.chomp
    return [name, city, semester, program, faculty]
  end

  def self.student_exist?(con)
    system("clear")
    print "Enter Student ID: "
    sid = gets.chomp.to_i
    query = "SELECT id FROM students where id=#{sid};"

    begin
      res = con.exec(query)
      raise "NOT FOUND" if res.num_tuples.zero?
    rescue => exception
      puts exception.message
    else
      # puts res[0]
      return sid
    end
  end

end