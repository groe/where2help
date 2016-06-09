class Shift < ApplicationRecord
  has_many :shifts_users
  has_many :users, through: :shifts_users
  belongs_to :event
  validates :volunteers_needed, :starts_at, :ends_at, presence: true
  validate :not_in_past

  default_scope { order(starts_at: :asc) }
  scope :is_not_full, -> { where("volunteers_needed > volunteers_count") }

  before_destroy :notify_volunteers, prepend: true

  private

  def notify_volunteers
    users.find_each do |user|
      # calling deliver_now here because othewise won't have shift available
      UserMailer.shift_destroyed(self, user).deliver_now
    end
  end

  def not_in_past
   errors.add(:starts_at, :not_in_past) if starts_at < Time.now()
   errors.add(:ends_at, :not_in_past)   if ends_at < Time.now
 end
end
