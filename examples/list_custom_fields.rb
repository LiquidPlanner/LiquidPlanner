# Require the LiquidPlanner API.
require File.expand_path("../lib/liquidplanner", File.dirname(__FILE__))

# Require support libraries used by this example.
require 'rubygems'
require 'highline/import'
require File.expand_path("./support/helper", File.dirname(__FILE__))


# List a set of custom fields and custom field values in a workspace.
#
# You will:
# * Access a workspace
# * Display the custom Project and custom Task fields in that workspace
#
# This example will use the highline library to handle input and output.
# You can install it with:
#     gem install highline

email, password, space_id = get_credentials!

# Create a new LiquidPlanner API object.  It requires the login credentials we gathered above.
lp = LiquidPlanner::Base.new(:email=>email, :password=>password)

# Fetch the user's workspace, and then print its name.
workspace = lp.workspaces(space_id)
say "#{workspace.name}: Custom Fields and Custom Field Values:" 
say "-" * 40

# Fetch custom fields for that workspace
custom_fields = workspace.custom_fields(:all)

# print the custom fields and custom field values
custom_fields.each do |cf|
  # LiquidPlanner::Resources::CustomField
  # LiquidPlanner::Resources::CustomField::Value

  # show the name, type, and value choices for the CustomField:
  say "category: #{cf.category}"       if cf.category
  say "name: #{cf.name} (id:#{cf.id})" if cf.name
  cf.values.each do |cfv| # custom_field_values
    say "label: #{cfv.label} (type: #{cfv.type} sort_order: #{cfv.sort_order} id: #{cfv.id})"
  end
  say "-" * 40
end