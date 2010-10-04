#!/usr/bin/env ruby
#
# This script is intended as a commit (or check-in, push, etc.) message
# processor with your SCM (Subversion, git, etc.) of choice. It scans the
# message for link(s) to tasks in LiquidPlanner, and creates a comment
# on each such task containing the text of the commit message.
#
# == Prerequisites
#
# You'll need a LiquidPlanner account and the liquidplanner gem.
#
# == Usage
#
# The script takes a single command-line parameter, which is the path to a
# YAML config file containing your LiquidPlanner credentials.
#
# So, you might create a post-commit.yml file containing:
#   
#   email:    your_email_address@example.com
#   password: your_liquidplanner_password
#
# Then you pass the commit message to the script on its standard input.
#
# Initially, try placing a test message (containing at least one link to a
# task in your LiquidPlanner workspace) in a file named commit_message.txt.
# Then run a command:
#
#   cat commit_message.txt | ruby ./post-commit.rb post-commit.yml
#
# This should create a comment on the linked task.
#
# == Integrating with your SCM
#
# Now it's just a matter of invoking this script on each commit to your SCM.
#
# Refer to the docs for your system of choice; we've included an example for
# Subversion in svn-post-commit.sh
#

require 'rubygems'
require 'liquidplanner'
require 'cgi'

class LiquidPlannerCommitMessenger

  # pattern for identifying task IDs in the message; this matches URLs copied
  # from LiquidPlanner, but you could choose to adopt a more compact notation
  # and modify this pattern accordingly
  #
  LINK_PATTERN = %r{https://app.liquidplanner.com/space/([0-9]+)/[^\/]+/show\?id=([0-9]+)}

  def initialize(email, password)
    @lp = LiquidPlanner::Base.new(:email => email, :password => password) 
  end

  # scan the message for one or more links to a LiquidPlanner task; for each
  # such link, create a comment on the referenced task containing the text of
  # the message
  def process_commit_message(message)
    comment = convert_message_to_comment(message)
    message.scan(LINK_PATTERN) do |space_id, task_id|
      add_comment(space_id, task_id, comment)
    end
  end

  protected

  # create a comment on the given task in the given space,
  # if they exist
  def add_comment(space_id, task_id, comment)
    if space = @lp.workspaces(space_id)
      if task = space.tasks(task_id)
        task.create_comment(:comment => comment)
      end
    end
  end

  # convert the commit message to HTML comment
  def convert_message_to_comment(message)
    # escape HTML, so that it can be read as comment text rather than
    # interpreted as markup
    m = CGI::escapeHTML(message)

    # compress runs of newlines, and convert to br tags
    m = m.gsub(/([\r?\n\r?]){3,}/, "\n\n").gsub(/\r?\n\r?/, "<br/>")

    m
  end

end

if $0 == __FILE__

  config = YAML.load(File.read(ARGV[0]))
  email    = config["email"]
  password = config["password"]

  message = STDIN.read
  LiquidPlannerCommitMessenger.new(email, password).process_commit_message(message)

end

