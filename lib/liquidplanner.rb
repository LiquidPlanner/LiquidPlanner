$:.push File.expand_path(".", File.dirname(__FILE__))

module LiquidPlanner
  VERSION      = "0.0.5"
  API_BASE_URL = "https://app.liquidplanner.com/api"
end

require "active_resource"
require "net/http/post/multipart" # for uploading documents

# could also glob these paths and require all matches...
require "liquidplanner/base"
require "liquidplanner/liquidplanner_resource"
require "liquidplanner/resources/workspace_resource"

require "liquidplanner/resources/account"
require "liquidplanner/resources/member"
require "liquidplanner/resources/workspace"

require "liquidplanner/resources/move_or_package"
require "liquidplanner/resources/movable"
require "liquidplanner/resources/packageable"

require "liquidplanner/resources/treeitem"
require "liquidplanner/resources/container"
require "liquidplanner/resources/leaf"
require "liquidplanner/resources/root"
require "liquidplanner/resources/inbox"
require "liquidplanner/resources/task"
require "liquidplanner/resources/event"
require "liquidplanner/resources/milestone"
require "liquidplanner/resources/package"
require "liquidplanner/resources/folder"
require "liquidplanner/resources/project"
require "liquidplanner/resources/client"

require "liquidplanner/resources/luggage"
require "liquidplanner/resources/note"
require "liquidplanner/resources/comment"
require "liquidplanner/resources/document"
require "liquidplanner/resources/link"
require "liquidplanner/resources/estimate"
require "liquidplanner/resources/snapshot"
require "liquidplanner/resources/activity"
require "liquidplanner/resources/custom_field"

require "liquidplanner/ext/hash"
require "liquidplanner/ext/connection"
require "liquidplanner/ext/exceptions"
