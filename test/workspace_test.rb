require 'test/unit'
require 'mocha'
require File.dirname(__FILE__) + '/../lib/liquidplanner'

# Very Basic tests around the workspace resource to ensure that it generates proper calls to ActiveResource.
class WorkspaceTest < Test::Unit::TestCase
  def setup
    @email    = 'testing@example.com'
    @password = 'password'
    @lp       = LiquidPlanner::Base.new(:email=>@email, :password=>@password)
  end
  
  def test_showing_workspace
    id = 17
    LiquidPlanner::LiquidPlannerResource.connection
      .expects(:get)
      .with(regexp_matches(/workspaces\/#{id}\.json$/), anything)
      .returns({})
      
    @lp.workspaces(id)
  end
  
  def test_listing_workspaces
    LiquidPlanner::LiquidPlannerResource.connection
      .expects(:get)
      .with(regexp_matches(/workspaces\.json$/), anything)
      .returns([])
      
    @lp.workspaces
  end
end