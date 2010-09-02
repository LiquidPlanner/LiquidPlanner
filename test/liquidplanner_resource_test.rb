require 'test/unit'
require 'mocha'
require File.dirname(__FILE__) + '/../lib/liquidplanner'

# Test that the special behaviors that LiquidPlanner expects behave sanely.
class LiquidPlannerResourceTest < Test::Unit::TestCase
  def setup
    @email    = 'testing@example.com'
    @password = 'password'
    @lp       = LiquidPlanner::Base.new(:email=>@email, :password=>@password)
  end
  
  # LiquidPlanner does not include redundant data in the responses, ensure that workspace_id is preserved
  def test_loading_does_not_clobber_prefix_options
    id = 7
    task = LiquidPlanner::Resources::Task.new()
    task.prefix_options = {:workspace_id=>id}
    task.load(:name=>'cake')
    
    assert_equal id, task.workspace_id
  end
  
  # Newly built resources should inherit their parent's prefix options and id as a new prefix option
  def test_building_new_resources
    task_id      = 7
    workspace_id = 9
    comment_text = "hello"
    
    task = LiquidPlanner::Resources::Task.new(:workspace_id=>workspace_id, :id=>task_id, :name=>'new task')
    comment = task.build_comment(:comment=>comment_text)
    assert_equal LiquidPlanner::Resources::Comment, comment.class
    
    assert_equal task_id, comment.prefix_options[:item_id]
    assert_equal workspace_id, comment.prefix_options[:workspace_id]
    assert_equal comment_text, comment.comment
  end
end