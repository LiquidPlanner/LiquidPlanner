#------------------------------------------------------------------------
# leaves
#------------------------------------------------------------------------

module LiquidPlanner
  module Resources
    class Leaf < Item
      include Priority
      include Order

      TRACK_TIME_KEYS = [ :work, :activity_id, :member_id, :low, :high, :is_done, :done_on, :work_performed_on, :comment ].freeze
      def track_time( options={} )
        options.assert_valid_keys( *TRACK_TIME_KEYS )
        request_body = options.to_json
        response = post(:track_time, {}, request_body)
        load( self.class.format.decode( response.body ) )
      end

    end
  end
end

