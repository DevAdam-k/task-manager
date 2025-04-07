# app/jobs/task_notification_job.rb
class TaskNotificationJob < ApplicationJob
  queue_as :default

  def perform(title)
    Rails.logger.info "Task Created: #{title}"
  end
end
