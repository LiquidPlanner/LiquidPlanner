# Require the LiquidPlanner API.
require File.expand_path("../lib/liquidplanner", File.dirname(__FILE__))

# Require support libraries used by this example.
require 'highline/import'
require File.expand_path("./support/helper", File.dirname(__FILE__))

# List a set of tasks in a workspace.
#
# You will:
# * Access a workspace
# * Retrieve the next 5 tasks assigned to you
# * Display the details of each task
#
# This example will use the highline library to handle input and output.
# You can install it with:
#     gem install highline

email, password, space_id = get_credentials!

# Create a new LiquidPlanner API object.  It requires the login credentials we gathered above.
lp = LiquidPlanner::Base.new(:email=>email, :password=>password)

# Fetch the user's workspace, and then print its name.
workspace = lp.workspaces(space_id)
say workspace.name
say "-" * 40

# Fetch up to 5 tasks in the user's workspace, filter to tasks owned by this user
tasks = workspace.tasks(:all, :limit=>5, :filter=>'owner_id = me')

# Print each task.
# If the task is done, say when it was completed.
# Otherwise we will print the appropriate information for the task.
tasks.each do |task|
  say task.name
  if task.is_done
    say "completed on: #{task.done_on.to_date}"
  else
    case task
      when LiquidPlanner::Resources::Task
        # Normal tasks should show their promise date, and expected completion date:
        say "due: #{task.promise_by.to_date}" if task.promise_by
        say "expected: #{task.expected_finish.to_date}" if task.expected_finish
        
      when LiquidPlanner::Resources::Milestone
        # Milestones should show their date
        say "date: #{task.date.to_date}"
        
      when LiquidPlanner::Resources::Event
        # Events should show their start to completion date
        say "from: #{task.start_date.to_date}"
        say "to: #{task.finish_date.to_date}"
    end
  end
  
  # Print the description
  say "#{task.description}\n"
  say "-" * 40
end