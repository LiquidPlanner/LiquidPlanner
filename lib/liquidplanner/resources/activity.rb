module LiquidPlanner
  module Resources
    class Activity < Luggage

      self.prefix = "/api/workspaces/:workspace_id/"

      def collection_path(options = nil)
        ret = super
        puts ret.inspect
        return ret unless options && options.item_id
        "#{super}/#{options.item_id}"
      end
      
    end
  end
end
