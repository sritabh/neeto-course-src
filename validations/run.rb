require 'colorize'
require_relative './src/validation_service'

puts "Running validations".yellow
puts ("-" * 80).yellow
puts "\n"

Src::ValidationService.new.process


