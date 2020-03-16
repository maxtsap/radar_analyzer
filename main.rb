require 'bundler/inline'
require_relative 'controllers/main_controller'
require_relative 'initialize'

if ARGV.empty?
  abort("Pass file name as argument.")
end

if File.exists?(ARGV.first.to_s)
  file_path = ARGV.first
elsif File.exists?(File.join(__dir__, ARGV.first.to_s))
  file_path = File.join(__dir__, ARGV.first)
else
  abort("Can't find file.")
end

file_content = File.read(File.join(__dir__, ARGV.first))

main_controller = MainController.new

puts main_controller.show_matches(file_content)
