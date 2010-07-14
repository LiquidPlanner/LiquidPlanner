# Require the LiquidPlanner API.
require File.dirname(__FILE__) + '/../lib/liquidplanner'

# Require support libraries used by this example.
require 'rubygems'                  
require 'highline/import'
require File.dirname(__FILE__) + '/support/helper'

# Get the user's credentials
email, password, space_id = get_credentials!

# Connect to LiquidPlanner and get the workspace
lp = LiquidPlanner::Base.new(:email=>email, :password=>password)
workspace = lp.workspaces(space_id)

# Ask for a task's name and estimate
say "Add a new task to '#{workspace.name}'"
name  = ask("New task name")
low   = ask("Min effort", Float)
high  = ask("Max effort", Float){|q| q.above = low}

# Submit the task and estimate
say "Submitting: '#{name}' [#{low} - #{high}] to LiquidPlanner"
task = workspace.create_task(:name=>name)
task.create_estimate(:low=>low, :high=>high)

# All done
say "Added task"