# Require the LiquidPlanner API.
require File.dirname(__FILE__) + '/../lib/liquidplanner'

# Require support libraries used by this example.
require 'rubygems'                  
require 'highline/import'
require File.dirname(__FILE__) + '/support/helper'

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
custom_fields = workspace.custom_fields(:all)

if tasks.empty?
  say "No tasks are assigned to you."
  exit
else
  task = tasks.first
end

say "Workspace: #{workspace.name} - Set a Custom Field Value on the first Task, Milestone, or Event in your space"
say "#{task.type}: #{task.name}"
say "* available Custom Task Fields:"

# allows you to set all custom fields available on this task
custom_fields.each do |cf|
  cf_name = cf.name
  case cf.category
    when "task" # custom_fields can be of category: 'task' or 'project'
      say "#{cf.name}"
      cf_name = cf.name
      cf.values.each do |cfv| # options to choose from
        say "#{cfv.label}"
      end
      cf_value = ask("Type in the Custom Field Value you wish to set on '#{task.name}'?", String)
      puts "chose: #{cf_value}"
      # HTTP PUT "'{'task':{'custom_field_values':{'mark_task_fields':'redgrind'}}}'"
      task.custom_field_values = {cf_name => cf_value}
      task.save
  end    
end  