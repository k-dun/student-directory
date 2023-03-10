require 'csv'

@students = []

def print_menu
  puts "1. Create student records."
  puts "2. Print all student records."
  puts "3. Save student records to file."
  puts "4. Load student records from file."
  puts "9. Exit."
end

def process(selection)
  case selection
  when "1"
    create_student_records
  when "2"
    print_all_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    puts "Quitting student directory.."
    exit
  else
    puts "Wrong input. Try again." 
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

def create_student_records
  puts "Please enter the names and cohorts of each student."
  print "Name: "
  name = STDIN.gets.chomp
  
  next_student = true
  
  while next_student do
    print "Cohort: "
    cohort = STDIN.gets.chomp

    cohort = "Unspecified" if cohort == ""

    @students << { name: name, cohort: cohort.to_sym, age: :age, nationality: :nationality, hobbies: :hobbies }

    puts "Now we have #{@students.count} student." if @students.count == 1
    puts "Now we have #{@students.count} students." if @students.count > 1
    
    choice = ""

    until choice == "y" || choice == "n"
      print "\nDo you want to enter another student info (y/n) : "
      choice = STDIN.gets.chomp
      if choice == "y"
        print "Name: "
        name = STDIN.gets.chomp
        break
      elsif choice == "n"
        next_student = false
        break
      end
    end
  end

  puts "\nYou successfully added records of #{@students.count} students!\n"
end

def save_students
  print "Enter filename: "
  filename = STDIN.gets.chomp

  if File.exist?(filename)
    puts "This file already exists. Do you want to overwrite the data? (y/n)"
    choice = STDIN.gets.chomp
      
    if choice == "y"
      CSV.open(filename, "w+") do |csv|
        @students.each do |student|
          csv << [student[:name], student[:cohort]]
        end
      end
    elsif choice == "n"
      save_students
    else
      puts "Wrong input. Try again!"
      save_students
    end
  else
    CSV.open(filename, "w+") do |csv|
      @students.each do |student|
        csv << [student[:name], student[:cohort]]
      end
    end
  end
  
  puts "Successfully saved student data to file!\n"
end

def load_students(filename = "students.csv")
  @students = []
  puts "Enter filename: "
  filename = STDIN.gets.chomp

  CSV.foreach(filename) do |line|
    @students << { name: line[0], cohort: line[1].to_sym }
  end

  puts "Successfully loaded student data from file!\n"
end

def try_load_students
  filename = ARGV.first

  if filename.nil?
    load_students("students.csv")
    puts "Loaded #{@students.count} from students.csv"
  else
    return if filename.nil?
    if File.exist?(filename)
      load_students(filename)
      puts "Loaded #{@students.count} from #{filename}!"
    else
      puts "Sorry #{filename} doesn't exist."
      exit
    end
  end
end

def print_header
  puts "\nThe students of Villains Academy"
  puts "-----------\n"
end

def print_by_name
  i = 0
  @students.each { |student|
    print "#{i + 1}. #{student[:name]}".ljust(30, " ")
    puts "(#{student[:cohort].to_s} cohort)".ljust(60, " ")
    i += 1
  }
end

def print_by_cohort
  i = 0
  cohorts = []
  @students.each { |student| cohorts << student[:cohort] }
  cohorts.uniq.each { |cohort|
    @students.each { |student|
      if student[:cohort] == cohort
        print "#{i + 1}. #{student[:name]}".ljust(30, " ")
        puts "(#{student[:cohort].to_s} cohort)".ljust(60, " ")
        i += 1
      end
    } 
  }
end

def print_all_students
  print_header
  print_by_name
  print_footer
end

def print_footer
  puts "\nOverall we have #{@students.count} great students!\n"
end

def print_source_code
  puts File.read(__FILE__)
end

interactive_menu