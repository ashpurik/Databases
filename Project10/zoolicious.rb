#!/usr/bin/env ruby
# Author: Anastasia Shpurik
# Project10 - MongoDB

require 'mongo'

include Mongo 

db = MongoClient.new("staff.mongohq.com", 10033).db("zoolicious")
db.authenticate("csci403", "wuwnosql403")

#list zoo names
def print_zoo_names(db)
  puts "Zoo Names"
  zoos = db["zoos"]
  zoos.find.each do |zoo|
    puts "-- #{zoo["name"]}"
  end
end

#list habitat names & descriptions
def print_habitats(db)
  puts "Habitats"
  habitats = db["habitats"]
  i=1
  habitats.find.each do |habitat|
    printf("#{i}) #{habitat["name"]}")
    printf(": #{habitat["description"]}") unless habitat["description"] == nil
    printf("\n")
    i+=1
  end
end

#list animal names, descriptions, and cuteness levels
def print_animals(db)
  puts "Animals"
  animals = db["animals"]
  i=1
  animals.find.each do |animal|
    puts "#{i}) #{animal["name"]}"
    puts "  --Description: #{animal["description"]}" unless animal["description"] == nil
    puts "  --Cuteness Level: #{animal["cuteness"]}" unless animal["cuteness"] == nil
    i+=1
  end
end

def print_menu
  puts "\nMain Menu"
  puts "A. List zoo names"
  puts "B. List habitats"
  puts "C. List animals"
  puts "Q. Quit"
end

def do_command(command, db)
  case command
  when "A"
    print_zoo_names(db)
  when "B"
    print_habitats(db)
  when "C"
    print_animals(db)
  when "Q"
    puts "Exiting. Good-bye"
  when "q"
    puts "Exiting. Good-bye"
  else
    puts "Invalid choice."
  end
end

command = nil
puts "Welcome to the Zoolicious Database"
while (!(command == 'Q' || command == 'q'))
  print_menu
  do_command(command = gets.chomp!, db)
end

