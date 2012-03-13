#------------------------------------------------------------------------
# leaves
#------------------------------------------------------------------------
module LiquidPlanner
  module Resources
    class Leaf < Treeitem
      include Movable
      include Packageable

      TRACK_TIME_KEYS = [ :work, :activity_id, :member_id, :low, :high, :is_done, :done_on, :work_performed_on, :comment ].freeze
      def track_time( options={} )
        options.assert_valid_keys( *TRACK_TIME_KEYS )
        request_body = options.to_json
        # ActiveResource post() by default:
        #   response = post(:track_time, {}, request_body) 
        # will set this route with 'new': /api/workspaces/36/tasks/new/activities.json
        # it's because of how it sets @persisted = true by default, calling custom_method_new_element_url()
        # what we want is: /api/workspaces/36/tasks/:id/activities.json, which is accomplished here:
        response = connection.post(custom_method_element_url(:track_time, options), request_body)
        load( self.class.format.decode( response.body ) )
      end

    end
  end
end

