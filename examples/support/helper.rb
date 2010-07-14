# Turn on request tracking if the `VERBOSE` environment variable is set:
if ARGV.last == '--verbose'
  ARGV.pop
  require File.dirname(__FILE__) + '/../../lib/liquidplanner/debug'
  LiquidPlanner.watch_requests! do |method, request, payload|
    say "<%= color('[#{method}] #{request}', :green)%>"
  end
end

# This helper is used by the example files to  get a user's email, password, 
# and workspace id.
def get_credentials!
  # Get the user's Email and Workspace ID from the command line arguments.
  # See usage below for how this should be called.
  if ARGV.length == 2
    email     = ARGV.shift
    space_id  = ARGV.shift.to_i
  else
    puts "Usage:"
    puts "  ruby #{$0} <account> <workspace id>"
    puts "Example:"
    puts "  ruby #{$0} alice@example.com 7"
    exit 1
  end
  
  # Work around a highline bug:
  HighLine.track_eof = false
  
  # We use the highline library here to request the user's password.
  # Passwords should never be stored in plain text.
  password  = ask("LiquidPlanner password for #{email}:") {|q| q.echo = false}

  return email, password, space_id
end