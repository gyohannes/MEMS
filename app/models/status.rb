class Status < ApplicationRecord

  default_scope {where.not(id: disposed_status)}

  has_many :equipment


  def self.disposed_status
    Status.find_by(name: 'Disposed').try(:id)
  end

  def to_s
    name
  end

end
