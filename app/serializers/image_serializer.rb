class ImageSerializer
  include FastJsonapi::ObjectSerializer
  set_id { 'null' }
  attributes :url, :images, :credits
end