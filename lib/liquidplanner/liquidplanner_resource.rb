module LiquidPlanner

  # generic resource, extended by all LiquidPlanner::Resources
  class LiquidPlannerResource < ActiveResource::Base
    self.format               = :json
    self.include_root_in_json = true
    
    # LiquidPlanner does not send back data that is already in the path (prefix_options), so merge
    # any values that the object already had back into the prefix_options.
    def load(attributes)
      initial_prefix_options = @prefix_options.clone
      super
      @prefix_options.merge!(initial_prefix_options){|k, old_attr,new_attr| old_attr || new_attr }
      self
    end

    def get_raw(custom_method_name, options = {})
      connection.get_raw(custom_method_element_url(custom_method_name, options), self.class.headers)
    end
    
    private
    # Override the default instantiate_record to support polymorphic types
    # based on the `type` attribute LiquidPlanner returns.
    def self.instantiate_record(record, prefix_options = {})
      if record['type']
        cls = LiquidPlanner::Resources.const_get(record['type'])
      else
        cls = self
      end
      
      cls.new(record).tap do |resource|
        resource.prefix_options = prefix_options
      end
    end
    
    # Builds a new resource from the current one.
    def build_new_resource(klass, attributes={})
      raise ArgumentError, "#{klass} should subclass #{LiquidPlannerResource}" unless klass < LiquidPlannerResource
      klass.new(attributes).tap do |item|
        item.prefix_options = self.prefix_options.clone
      end
    end
    
    # Special handling for creating associated resources.  For instance:
    #   workspace.create_task(:name=>'new task').create_estimate(:low_effort=>1, :high_effort=>3)
    def method_missing(name, *args)
      if name.to_s =~ /^(create|build)_(.+)/
        operation   = $1.to_sym
        resource    = $2
        attributes  = args.shift || {}
        klass = LiquidPlanner::Resources.const_get(resource.classify)
        obj = build_new_resource(klass, attributes)
        obj.save if operation == :create
        obj
      else
        super
      end
    end
    
  end

end
