module PaginateAndSort
    def paginate_and_sort(page, sort, custom = nil)
      options = self.sort_by(sort) || {}

      if custom.nil?
        return self.paginate( options.merge( :per_page => 15, :page => page || 1 )) rescue []
      else
        values  = []
        method  = nil

        custom.each_pair do |key, value|
          method  = (method.nil?) ? "paginate_by_#{key.to_s}" : "#{method}_and_#{key.to_s}"
          values << value
        end
        values << options.merge(:per_page => 15, :page => page || 1)
        return self.send(method.to_sym, *values) rescue []
      end
    end
end

