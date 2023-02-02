@students = []

def print_menu
  puts "1. Create student records"
  puts "2. Print all student records"
  puts "3. Save student records to students.csv"
  puts "4. Load student records from students.csv"
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
  puts "Please enter the names and cohorts of the students"
  puts "(To finish, just type 'stop' when asked for name)"

  print "Name: "
  name = STDIN.gets.chomp

  if name == ""
    return []
  else
    while name != "stop" do
      print "Cohort: "
      cohort = STDIN.gets.chomp

      cohort = "Unspecified" if cohort == ""

      @students << { name: name, cohort: cohort.to_sym, age: :age, nationality: :nationality, hobbies: :hobbies }

      puts "Now we have #{@students.count} student." if @students.count == 1
      puts "Now we have #{@students.count} students." if @students.count > 1

      print "Name: "
      name = STDIN.gets.chomp
    end
  end
end

def save_students
  file = File.open("students.csv", "w")

  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end

  file.close
end

def load_students(filename = "students.csv")
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    @students << { name: name, cohort: cohort.to_sym }
  end
  
  file.close
end

def try_load_students
  filename = ARGV.first
  return if filename.nil?
  if File.exist?(filename)
    load_students(filename)
    puts "Loaded #{@students.count} from #{filename}"
  else
    puts "Sorry #{filename} doesn't exist."
    exit
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

try_load_students
interactive_menu