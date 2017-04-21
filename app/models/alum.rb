class Alum < ActiveRecord::Base
  attr_accessible :email, :grad_year, :job_now, :name, :staff_position, :where_you_live
  validates :name, :email, presence: true
  validates :grad_year, numericality: { only_integer: true }
end
