class Task < ApplicationRecord
  has_one_attached :image

  validates :title, presence: true, uniqueness: true
  validates :due_date, presence: true
  validate :due_date_cannot_be_in_the_past

  after_create_commit :enqueue_notification_job

  def image_url
    Rails.application.routes.url_helpers.rails_blob_url(image, only_path: true) if image.attached?
  end

  private

  def due_date_cannot_be_in_the_past
    errors.add(:due_date, "must be in the future") if due_date.present? && due_date <= Date.today
  end

  def enqueue_notification_job
    TaskNotificationJob.perform_later(title)
  end
end
