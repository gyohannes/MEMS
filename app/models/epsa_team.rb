class EpsaTeam < ApplicationRecord
  belongs_to :institution
  belongs_to :previous_team, optional: true, :class_name => 'EpsaTeam', :foreign_key => "previous_team_id"
  has_one :sub_team, :class_name => 'EpsaTeam', :foreign_key => "previous_team_id"
  has_many :request_statuses
  has_many :epsa_statuses

  def self.entry_team
    where(previous_team_id: '').first rescue nil
  end
  def to_s
    name
  end
end
