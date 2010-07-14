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

say workspace.name
say "-" * 40

# Get the user's tasks
tasks = workspace.tasks(:all, :filter=>'owner_id = me', :include_associated=>'activities')

if tasks.empty?
  say "No tasks are assigned to you."
  exit
end

# Pick a task to log time for
choose do |menu|
  menu.prompt = "Log time for:"
  tasks.each do |t|
    menu.choice(t.name) do
      say t.name
      work   = ask("Log how much?    (hours)", Float)
      low    = ask("New low effort:  (hours)", Float)
      high   = ask("New high effort: (hours)", Float){|q| q.above = low}
      
      activity_id = 0
      if !t.activities.empty?
        choose do |activity_menu|
          activity_menu.prompt = "Use activity:"
          t.activities.each do |act|
            activity_menu.choice(act.name) do
              activity_id = act.id
            end
          end
        end
      end

      t.track_time :low=>low, :high=>high, :member_id=>account.id, :work=>work, :activity_id=>activity_id
    end
  end
end