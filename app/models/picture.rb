class Picture < ActiveRecord::Base
  has_attached_file :thumbnail, styles: { medium: '300x300>' }
  validates_attachment :thumbnail, content_type: { content_type: %w(image/jpg image/jpeg image/png image/gif) }
end
