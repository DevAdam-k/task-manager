# 📝 Task Manager – Rails 7 + Turbo + Tailwind

A lightweight task management app built using Ruby on Rails 7, Turbo Frames/Drive, Active Storage, and Active Job. Users can create tasks, upload images, and get real-time task updates — all with minimal dependencies and modern Hotwire interactivity.

---

## 🚀 Features

- ✅ Create, read, update, and delete tasks
- 📸 Upload an image for each task (using Active Storage)
- 🔔 Trigger a background notification job when a task is created (via Active Job)
- ⚡ Mark tasks as completed
- 🧠 Filter by completed/pending tasks
- 🔁 Turbo Frames for partial page updates
- 🌐 JSON API endpoint: `/api/tasks`

---

## 🛠 Setup Instructions (Development)

### 1. Clone & install dependencies

`import the project and install dependencies`

```bash
git clone https://github.com/your_username/task_manager.git
cd task_manager
bundle install
```

### 2. Set up the database

```bash
rails db:setup
```

This creates the database, runs migrations, and seeds initial data (if any).

### 3. Start the server

```bash
bin/dev
```

> Uses `hotwire-rails` and `importmap` — no need for Webpack or Node.js.

---

## 📦 Key Concepts Used

### 📂 Active Storage

Handles file/image uploads. We use `has_one_attached :image` on the `Task` model to attach images and store them locally.

```ruby
task.image.attached?
image_tag task.image.variant(resize_to_limit: [400, 400])
```

### 🔄 Turbo (Turbo Frames + Drive)

Partial page updates, inline form rendering, and SPA-like UX — without JavaScript.

- Used for inline task form loading
- Turbo Streams for background rendering and redirecting

### 📩 Active Job

Used for simulating background notifications when a new task is created:

```ruby
after_create_commit :enqueue_notification_job

def enqueue_notification_job
  TaskNotificationJob.perform_later(title)
end
```

Jobs are processed async using the default queue adapter.

---

## 🌍 Deployment on Ubuntu (Manual)

Assumes a basic Ubuntu setup with PostgreSQL, Ruby, Rails, and Nginx + Puma.

### 1. Install dependencies

```bash
sudo apt update && sudo apt install -y git curl gnupg nginx postgresql libpq-dev
```

Install Ruby, Node.js, Yarn (via rbenv or rvm), and then:

```bash
gem install rails
```

### 2. Clone your app

```bash
git clone https://github.com/your_username/task_manager.git
cd task_manager
bundle install
```

### 3. Set up environment

```bash
RAILS_ENV=production
rails assets:precompile
rails db:setup
```

### 4. Set up Puma or Passenger (for production)

Configure `nginx` to reverse proxy to Puma or use Passenger with Nginx integration.

---

## 🔧 API Endpoint

**GET** `/api/tasks`

Returns all tasks as JSON:

```json
[
  {
    "id": 1,
    "title": "Buy groceries",
    "description": "Milk, bread, eggs",
    "due_date": "2025-04-10",
    "completed": false,
    "image_url": "/rails/active_storage/blobs/..."
  }
]
```

---

## 🧩 Troubleshooting

| Problem | Solution |
|--------|----------|
| `image_processing` gem missing | Add `gem "image_processing", "~> 1.2"` to `Gemfile` and run `bundle install` |
| Turbo frame not replacing content | Ensure the frame`s `id` matches the `target` in the Turbo Stream |
| Redirect not working with Turbo | Add a custom Turbo Stream action or Stimulus controller |
| `rails_blob_url` returns `nil` | Set `Rails.application.routes.default_url_options[:host]` in `development.rb` |
| CSS or JS not loading | Ensure you’ve run `bin/dev` (using `importmap`) or compiled assets in production |

---

## 🧠 Tech Stack

- Ruby 3.x, Rails 7.x
- Turbo (Hotwire), Stimulus
- Tailwind CSS (via Tailwind Rails)
- Active Storage (file uploads)
- Active Job (background jobs)
- PostgreSQL (or SQLite for local dev)
- Puma/Nginx (for deployment)

---

## 👨‍💻 Author

Created by [Your Name](https://github.com/your_username) as part of a Ruby on Rails technical assessment.

---
