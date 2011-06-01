module LiquidPlanner
  module MoveOrPackage
    def move_or_package(motion, relative, other, is_packaged_other=false)

      raise ArgumentError.new("motion must be move or package")   unless [:move, :package].include?(motion)
      raise ArgumentError.new("relative must be before or after") unless [:before, :after].include?(relative)
      action = "#{motion}_#{relative}"

      other_id = other.is_a?(LiquidPlanner::LiquidPlannerResource) ? other.id : other

      params = {}
      if is_packaged_other && :move == motion
        params[:packaged_other_id] = other_id
      else
        params[:other_id] = other_id
      end

      response = post(action, params)

      load( self.class.format.decode( response.body ) )
    end
  end
end
