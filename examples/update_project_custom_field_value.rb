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
projects = workspace.projects(:all, :filter=>'owner_id = me')
custom_fields = workspace.custom_fields(:all)

if projects.empty?
  say "No tasks are assigned to you."
  exit
else
  project = projects.first
end

say "Workspace: #{workspace.name} - Set a Custom Field Value on a Project"
say "#{project.type}: #{project.name}"
say "* available Custom Project Fields:"

# allows you to set all custom fields available on this task
custom_fields.each do |cf|
  cf_name = cf.name
  case cf.category
    when "project" # custom_fields can be of category: 'task' or 'project'
      say "#{cf.name}"
      cf_name = cf.name
      cf.values.each do |cfv| # options to choose from
        say "#{cfv.label}"
      end
      cf_value = ask("Type in the Custom Field Value you wish to set on '#{project.name}'?", String)
      say "chose: #{cf_value}"
      project.custom_field_values = {cf_name => cf_value}
      project.save
  end    
end