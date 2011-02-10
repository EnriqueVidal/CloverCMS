class Setting < ActiveRecord::Base
  validates_presence_of  :name, :value
  validates_uniqueness_of :name

  validates_format_of :name, :with => /^[a-z0-9_]+$/

  def delete
    if destroyable?
      super
    else
      false
    end
  end

  def delete!
    if destroyable?
      super
    else
      false
    end
  end
end
