# Require the LiquidPlanner API.
require File.expand_path("../lib/liquidplanner", File.dirname(__FILE__))

# Require support libraries used by this example.
require 'rubygems'
require 'highline/import'
require File.expand_path("./support/helper", File.dirname(__FILE__))

# Create a new task in the workspace
#
# You will:
# * Access a workspace
# * Create and estimate a task
#
# This example will use the highline library to handle input and output.
# You can install it with:
#     gem install highline

# Get the user's credentials
email, password, space_id = get_credentials!

# Connect to LiquidPlanner and get the workspace
lp = LiquidPlanner::Base.new(:email=>email, :password=>password)
workspace = lp.workspaces(space_id)

# Pick the first container in the workspace to place the task in:
parent = workspace.packages(:first) || workspace.projects(:first)

# Ask for a task's name and estimate
say "Add a new task to '#{workspace.name}'"
name  = ask("New task name")
low   = ask("Min effort", Float)
high  = ask("Max effort", Float){|q| q.above = low}

# Submit the task and estimate
say "Submitting: '#{name}' [#{low} - #{high}] to LiquidPlanner"
task = workspace.create_task(:name=>name, :parent_id => parent.id)
task.create_estimate(:low=>low, :high=>high)

# All done
say "Added task"
