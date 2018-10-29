class Installation < ApplicationRecord
  belongs_to :equipment
  belongs_to :department
end
