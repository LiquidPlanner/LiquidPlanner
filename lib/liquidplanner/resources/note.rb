module LiquidPlanner
  module Resources
    class Note < Luggage

      # an item has either 0 or 1 note; the "collection" is singular in name,
      # and should be accessed as:
      #
      # /api/workspaces/:workspace_id/:items/:item_id/note <= without /ID.json suffix
      #
      self.collection_name = 'note'

      def self.element_path(id, prefix_options = {}, query_options = nil)
        path = super(id, prefix_options, query_options)
        path.sub!( "/#{id}.#{format.extension}", "" )
        path
      end

    end
  end
end

