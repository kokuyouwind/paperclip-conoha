class AddAttachmentThumbnailToPictures < ActiveRecord::Migration
  def self.up
    change_table :pictures do |t|
      t.attachment :thumbnail
    end
  end

  def self.down
    remove_attachment :pictures, :thumbnail
  end
end
