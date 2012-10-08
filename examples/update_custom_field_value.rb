# Require the LiquidPlanner API.
require File.expand_path("../lib/liquidplanner", File.dirname(__FILE__))

# Require support libraries used by this example.
require 'rubygems'
require 'highline/import'
require File.expand_path("./support/helper", File.dirname(__FILE__))


require 'pp'
# Get the user's credentials
email, password, space_id = get_credentials!

# Create a new LiquidPlanner API object with the login credentials
lp = LiquidPlanner::Base.new(:email=>email, :password=>password)

# Get the user's workspace and account, and then print its name.
workspace   = lp.workspaces(space_id)
account     = lp.account

say "-" * 40
# Get the user's first task
tasks = workspace.tasks(:all, :filter=>'owner_id = me')
projects = workspace.projects(:all, :filter=>'owner_id = me')

custom_task_fields    = workspace.custom_fields(:all).select{|item| item.category == "task"}
custom_project_fields = workspace.custom_fields(:all).select{|item| item.category == "project"}

if tasks.empty? && projects.empty?
  say "No tasks or projects are assigned to you."
  exit
else
  task    = tasks.first
  project = projects.first
end

say "Workspace: #{workspace.name} - Set a Custom Field Value on the first Task, Milestone, or Event in your space"
say "#{task.type}: #{task.name}"
say "* available Custom Task Fields:"

# allows you to set all custom fields available on this task
custom_task_fields.each do |cf|
  say "#{cf.name}"
  cf.values.each do |cfv| # options to choose from
    say "#{cfv.label}"
  end
  cf_value = ask("Type in the Custom Field Value you wish to set on '#{task.name}'?", String)
  puts "chose: #{cf_value}"
  # HTTP PUT "'{'task':{'custom_field_values':{'your_task_field':'your_task_field_value'}}}'"
  task.custom_field_values = {cf.name => cf_value}
  task.save
end

# allows you to set all custom fields available on this task
custom_project_fields.each do |cf|
  say "#{cf.name}"
  cf.values.each do |cfv| # options to choose from
    say "#{cfv.label}"
  end
  cf_value = ask("Type in the Custom Field Value you wish to set on '#{task.name}'?", String)
  puts "chose: #{cf_value}"
  project.custom_field_values = {cf.name => cf_value}
  project.save
end