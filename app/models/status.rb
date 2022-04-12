class Status < ApplicationRecord
  #default_scope {where.not(name: 'Disposed')}

  has_many :equipment
  has_many :inventories, dependent: :destroy
  has_many :maintenances, dependent: :destroy
  has_many :maintenance_requests

  before_save :set_name

  def set_name
    self[:name] = name.titlecase
  end

  def self.disposed_status
    Status.unscoped.find_by(name: 'Disposed').try(:id)
  end

  def to_s
    name
  end

end
