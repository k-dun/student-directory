def input_students
  puts "Please enter the names of the students"
  puts "To finish, just press return twice"

  students = []

  name = gets.chomp

  while !name.empty? do
    students << { name: name, cohort: :november, age: :age, nationality: :nationality, hobbies: :hobbies}
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end

  students
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

def print_names(names)
  i = 0
  while i < names.size do
    print "#{i + 1}. #{names[i][:name]}".ljust(30, " ")
    puts "(#{names[i][:cohort]} cohort)".rjust(60, " ")
    
    i += 1
  end
end

def print_footer(names)
  puts "Overall we have #{names.count} great students!"
end

students = input_students
print_header
print_names(students)
print_footer(students)
# filter_by_letter(students, "N")
# filter_by_length(students, 12)