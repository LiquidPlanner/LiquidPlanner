# LiquidPlanner Ruby Gem

The LiquidPlanner ruby gem provides a simple way to access LiquidPlanner's API. The [examples directory](https://github.com/LiquidPlanner/LiquidPlanner/tree/master/examples) demonstrates how to perform some common tasks with this gem.

## Documentation

- [LiquidPlanner API Guide](https://liquidplanner-wpengine.netdna-ssl.com/assets/api/liquidplanner_API.pdf)
- [Developer Resources](https://www.liquidplanner.com/support/articles/developer-tools/)
- [Developer Forum](https://liquidplanner.zendesk.com/forums/20563418)

## Installation

The LiquidPlanner API client can be installed with Rubygems or Bundler.

### Rubygems

```
gem install liquidplanner
```

### Bundler

Add to your Gemfile and run `bundle install`

``` ruby
gem 'liquidplanner'
```

### Dependencies

- `activeresource >= 4.0.0`
- `activesupport >= 4.0.0`
- `multipart-post >= 1.0.1`

## Usage

Please refer to our [API Guide](https://liquidplanner-wpengine.netdna-ssl.com/assets/api/liquidplanner_API.pdf) for a full list of endpoints, resources, and attributes. Additional examples are located in this repository's [examples directory](https://github.com/LiquidPlanner/LiquidPlanner/tree/master/examples).

This gem accesses the LiquidPlanner API via ActiveResource. Please read the [ActiveResource documentation](https://github.com/rails/activeresource) for additional usage details.

### Create a client and connect

``` ruby
lp = LiquidPlanner::Base.new(:email => email, :password => password)
account = lp.account # <LiquidPlanner::Resources::Member>
```

### Workspaces

``` ruby
lp.workspaces    # [<LiquidPlanner::Resources::Workspace>, <LiquidPlanner::Resources::Workspace>]
lp.workspaces(7) # Access workspace by ID
```

### Tasks

``` ruby
workspace = lp.workspaces(7)                                      # Access workspace by ID
tasks     = workspace.tasks                                       # List all tasks
my_tasks  = workspace.tasks(:all, :filter => 'owner_id = me')     # Use a filter
new_task  = workspace.create_task(:name => 'Learn API')           # Create and save a new task

my_tasks.each do |task|                                           # Task details
  puts "Name: #{task.name}"
  
  if task.is_done
    puts "Completed on: #{task.done_on.to_date}"
  else
    puts "Expected finish date: #{task.expected_finish.to_date}"
  end
end
```

### Custom Fields

``` ruby
workspace     = lp.workspaces(7)                        # Access workspace by ID

# List custom fields
#
custom_fields = workspace.custom_fields(:all)           # List all custom fields for workspace
custom_fields.each do |custom_field|
  puts "Category: #{custom_field.category}"             # Custom field attributes
  puts "Name:     #{custom_field.name}"
  
  custom_field.values.each do |custom_field_value|      # Custom field values
    puts "ID:         #{custom_field_value.id}"
    puts "Label:      #{custom_field_value.label}"
    puts "Type:       #{custom_field_value.type}"
    puts "Sort order: #{custom_field_value.sort_order}"
  end
end

# Update a custom field value
#
custom_field = workspace.custom_fields(:first)          # Access the first custom field
task = workspace.tasks(:first)                          # Access the first task
task.custom_field_values = { custom_field.name => custom_field.values.first }
task.save
```

### Time Tracking

``` ruby
workspace = lp.workspaces(7)                      # Access workspace by ID

task = workspace.tasks(                           # Get my first unfinished task
  :first, 
  :filter => ['owner_id = me', 'is_done is false']
) 

task.track_time(
  :work            => 4,                          # Log 4 hours of work 
  :activity_id     => task.activities.first.id
)
```

## Development

1. Fork this project
2. Make changes
3. Add tests for your changes
4. Commit
5. Submit a pull request
