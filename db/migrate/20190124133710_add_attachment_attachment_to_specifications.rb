class AddAttachmentAttachmentToSpecifications < ActiveRecord::Migration[5.1]
  def self.up
    change_table :specifications do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :specifications, :attachment
  end
end
