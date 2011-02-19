module Clover
  class UnauthorizedAccessError < SecurityError; end
  class PageNotFoundError < ActiveRecord::RecordNotFound; end
end
