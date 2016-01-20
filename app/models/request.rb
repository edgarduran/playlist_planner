class Request < ActiveRecord::Base
  belongs_to :user

  validates :status, presence: true, inclusion: { in: %w(pending approved denied) }



  scope :pending,  -> { where(status: 'pending') }
  scope :approved, -> { where(status: 'approved') }
  scope :denied,   -> { where(status: 'denied') }
end
