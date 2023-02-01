def create_student_records
  puts "Please enter the names and cohorts of the students"
  puts "(To finish, just type 'stop' when asked for name)"

  students = []

  puts "Name: "
  name = gets.chomp

  if name == ""
    return []
  else
    while name != "stop" do
      puts "Cohort: "
      cohort = gets.chomp

      cohort = "Unspecified" if cohort == ""

      students << { name: name, cohort: cohort.to_sym, age: :age, nationality:        :nationality, hobbies: :hobbies }

      puts "Now we have #{students.count} student." if students.count == 1
      puts "Now we have #{students.count} students." if students.count > 1

      puts "Name: "
      name = gets.chomp
    end
  end

  students
end

def update_student_records(names)
  puts "Which part of the student record do you want to update: "
  puts "Type 1 / 2"
  puts "1. Name"
  puts "2. Cohort"
  choice = gets.chomp
  
  if choice == "1"
    puts "Which name do you want to update: "
    name = gets.chomp
    puts "What is the new name: "
    updated_name = gets.chomp

    names.select { |student| student[:name] = updated_name if student[:name] == name }

    puts "Student's name updated!"
  elsif choice == "2"
    puts "Student's cohort updated!"
  else
    puts "Wrong input. Try again."
  end
end

def filter_by_letter(names, letter)
  puts "Here are students whose names start with the letter '#{letter}':"
  names.each { |name| puts name[:name] if name[:name][0] == letter }
end

def filter_by_length(names, length)
  puts "Here are the students whose names are shorter than #{length} characters:"
  names.each { |name| puts name[:name] if name[:name].length < 12 }
end

def print_header
  puts "The students of Villains Academy"
  puts "-----------"
end

def print_by_name(names)
  i = 0
  while i < names.size do
    print "#{i + 1}. #{names[i][:name]}".ljust(30, " ")
    puts "(#{names[i][:cohort].to_s} cohort)".ljust(60, " ")
    
    i += 1
  end
end

def print_by_cohort(names)
  i = 0
  cohorts = []
  names.each { |student| cohorts << student[:cohort] }
  cohorts.uniq.each { |cohort|
    names.each { |student|
      if student[:cohort] == cohort
        print "#{i + 1}. #{student[:name]}".ljust(30, " ")
        puts "(#{student[:cohort].to_s} cohort)".ljust(60, " ")
        i += 1
      end
    } 
  }

end

def print_footer(names)
  puts "Overall we have #{names.count} great students!"
end

students = create_student_records

if students == []
  puts "The student list is empty."
else  
  print_header
  print_by_name(students)
  print_footer(students)
end
# filter_by_letter(students, "N")
# filter_by_length(students, 12)
# update_student_records(students)
# print_by_cohort(students)