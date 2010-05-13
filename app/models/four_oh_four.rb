class FourOhFour < ActiveRecord::Base
  def self.add_request(host, path, referer)
    request = find_or_initialize_by_host_and_path_and_referer(host, path, referer)
    request.count += 1
    request.save
  end
end
