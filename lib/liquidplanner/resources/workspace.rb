module LiquidPlanner
  module Resources
    class Workspace < LiquidPlanner::LiquidPlannerResource

      def members( scope=:all, options={} )
        Member.find( scope, :params => { :workspace_id => self.id }.merge(options) )
      end

      def treeitems( scope=:all, options={} )
        Treeitem.find( scope, :params => { :workspace_id => self.id, :flat => true }.merge(options) )
      end

      def tasks( scope=:all, options={} )
        Task.find( scope, :params => { :workspace_id => self.id }.merge(options) )
      end

      def events( scope=:all, options={} )
        Event.find( scope, :params => { :workspace_id => self.id }.merge(options) )
      end

      def milestones( scope=:all, options={} )
        Milestone.find( scope, :params => { :workspace_id => self.id }.merge(options) )
      end

      def clients( scope=:all, options={} )
        Client.find( scope, :params => { :workspace_id => self.id, :flat => true }.merge(options) )
      end

      def projects( scope=:all, options={} )
        Project.find( scope, :params => { :workspace_id => self.id, :flat => true }.merge(options) )
      end

      def packages( scope=:all, options={} )
        Package.find( scope, :params => { :workspace_id => self.id, :flat => true }.merge(options) )
      end

      def folders( scope=:all, options={} )
        Folder.find( scope, :params => { :workspace_id => self.id, :flat => true }.merge(options) )
      end
      
      def custom_fields( scope=:all, options={} )
        CustomField.find( scope, :params => { :workspace_id => self.id }.merge(options) )
      end
            
      protected

      # create a new instance of klass (Task, Folder, etc.),
      # with the workspace_id set as a prefix option
      #
      # workspace.build_new_resource( LiquidPlanner::Resources::Task, :name => "new task" ).save
      #
      def build_new_resource( klass, attributes={} )
        super(klass, attributes).tap do |item|
          item.prefix_options[:workspace_id] = self.id
        end
      end

    end
  end
end
