class Status < ApplicationRecord
  has_many :equipment


  def self.disposed_status
    Status.find_by(name: 'Disposed').id
  end

  def to_s
    name
  end

end
