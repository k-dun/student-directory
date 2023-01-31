def input_students
  puts "Please enter the names of the students"
  puts "To finish, just press return twice"

  students = []
  name = gets.chomp

  while !name.empty? do
    students << { name: name, cohort: :november }
    puts "Now we have #{students.count} students"
    name = gets.chomp
  end

  students
end

def filter_students(names, letter)
  puts "Here are students whose names start with the letter '#{letter}'"
  names.each { |name| puts name[:name] if name[:name][0] == letter }
end

def print_header
  puts "The students of Villains Academy"
  puts "-----------"
end

def print_names(names)
  names.each { |name| puts "#{names.index(name) + 1}. #{name[:name]} (#{name[:cohort]} cohort)" }
end

def print_footer(names)
  puts "Overall we have #{names.count} great students!"
end

students = input_students
print_header
print_names(students)
print_footer(students)
# filter_students(students, "N")