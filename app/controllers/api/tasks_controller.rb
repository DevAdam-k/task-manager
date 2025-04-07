module Api
  class TasksController < ApplicationController
    def index
      tasks = Task.order(created_at: :desc)
      render json: tasks.as_json(only: [ :id, :title, :description, :due_date, :completed ], methods: [ :image_url ])
    end
  end
end
