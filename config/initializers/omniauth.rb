Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '113616556095', '0bae3b836f19e566b9c0cd5ad1a5933b'
  provider :twitter, '3Hhjym0fFhW5TdK4AsVhYQ', 'l2RRV8RrPaYSPLQ14HJdJXXVdBwnftHYkI34wecSwdQ'
  #provider :open_id, OpenID::Store::Filesystem.new('/tmp')
end