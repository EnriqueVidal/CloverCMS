module PaginateAndSort

  module ClassMethods
    def paginate_and_sort(page, sort, custom = nil)
      options = self.sort_by(sort) || {}

      if custom.nil?
        return self.paginate( options.merge( :per_page => 15, :page => page || 1 )) rescue []
      else
        key     = custom.keys.first.to_s
        value   = custom.values.first
        method  = ("paginate_by_" + key).to_sym
        
        return self.send(method, value, options.merge( :per_page => 15, :page => page || 1 )) rescue []
      end
    end
  end
  
  module InstanceMethods
  end
end