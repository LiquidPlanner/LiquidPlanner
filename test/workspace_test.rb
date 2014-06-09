require 'test/unit'
require File.dirname(__FILE__) + '/../lib/liquidplanner'

# Very Basic tests around the workspace resource to ensure that it generates proper calls to ActiveResource.
class WorkspaceTest < Test::Unit::TestCase
  def setup
    @email    = 'testing@example.com'
    @password = 'password'
    @lp       = LiquidPlanner::Base.new(:email=>@email, :password=>@password)

    ActiveResource::HttpMock.respond_to do |mock|
      headers = { 
        "Authorization"   => "Basic dGVzdGluZ0BleGFtcGxlLmNvbTpwYXNzd29yZA==",
        "accept-encoding" => "gzip",
        "Accept"          => "application/json"
      }

      space = { :workspace => { :name => "Space" } }

      mock.get "/api/workspaces.json",    headers, [ space ].to_json
      mock.get "/api/workspaces/17.json", headers, space.to_json
    end
  end
  
  def test_showing_workspace
    id = 17

    space = @lp.workspaces(id)

    assert_equal "Space", space.name
  end
  
  def test_listing_workspaces
    spaces = @lp.workspaces

    assert_equal 1, spaces.length
    assert_equal "Space", spaces.first.name
  end
end
