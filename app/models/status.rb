class Status < ApplicationRecord
  default_scope {where.not(id: disposed_status)}

  has_many :equipment

  before_save :set_name

  def set_name
    self[:name] = name.titlecase
  end

  def self.disposed_status
    Status.find_by(name: 'Disposed').try(:id)
  end

  def to_s
    name
  end

end
