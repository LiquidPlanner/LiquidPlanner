#------------------------------------------------------------------------
# generic item, could be a task, folder, tasklist, etc.
#------------------------------------------------------------------------
module LiquidPlanner
  module Resources
    class Treeitem < WorkspaceResource 

      def parent
        parent_id && Treeitem.find( :one, :from => "/api/workspaces/#{workspace_id}/treeitems/#{parent_id}" )
      end

      def package
        package_id && Package.find( :one, :from => "/api/workspaces/#{workspace_id}/packages/#{package_id}" )
      end

      def project
        project_id && Project.find( :one, :from => "/api/workspaces/#{workspace_id}/projects/#{project_id}" )
      end

      def client
        client_id && Client.find( :one, :from => "/api/workspaces/#{workspace_id}/clients/#{client_id}" )
      end

      def note
        Note.find( :one, :from => "/api/workspaces/#{workspace_id}/#{item_collection}/#{id}/note" ).tap do |n|
          n.prefix_options = luggage_params
        end
      end
      
      def activities( scope=:all )
        Activity.find( scope, :params => luggage_params )
      end
      
      def comments( scope=:all )
        Comment.find( scope, :params => luggage_params )
      end

      def documents( scope=:all )
        Document.find( scope, :params => luggage_params )
      end

      def attach_document( attached_file_path, options={} )
        doc = Document.upload_document( workspace_id, id, attached_file_path, options )
        doc.prefix_options = luggage_params
        doc
      end

      def links( scope=:all )
        Link.find( scope, :params => luggage_params )
      end

      def estimates( scope=:all )
        Estimate.find( scope, :params => luggage_params )
      end

      # LiquidPlanner::Item => 'items'
      def item_collection
        self.class.to_s.split('::').last.downcase.pluralize
      end

      def workspace_id
        prefix_options[:workspace_id]
      end

      protected
      
      def build_new_resource(klass, attributes={})
        super(klass, attributes).tap do |item|
          item.prefix_options = luggage_params
        end
      end

      def luggage_params
        {
          :workspace_id    => self.workspace_id,
          :item_collection => self.item_collection,
          :item_id         => self.id
        }
      end

    end
  end
end
