class Backup < ApplicationRecord
  has_one_attached :attachment

  def attachment_on_disk
    ActiveStorage::Blob.service.send(:path_for, attachment.key)
  end

end
