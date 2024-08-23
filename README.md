# ActiveJobCronScheduler

ActiveJobCronScheduler is a Ruby on Rails gem that provides a simple and efficient way to schedule recurring jobs in your Rails application. It leverages ActiveJob and provides a clean DSL for defining job schedules.

## Features

- Simple DSL for scheduling recurring jobs
- Built on top of ActiveJob for seamless integration with Rails
- Prevents parallel execution of the same job
- Stores execution history for debugging purposes
- No external dependencies (like Redis) required

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_job_cron_scheduler'
```

And then execute:

```
$ bundle install
```

After installing the gem, run the installation generator:

```
$ rails generate active_job_cron_scheduler:install
```

This will create a migration file. Run the migration to create the necessary database table:

```
$ rails db:migrate
```

## Usage

### Defining a Job

To create a job that runs on a schedule, simply include the `ActiveJobCronScheduler::ActiveJobCronScheduler` module in your job class and use the `schedule_each` method to define the schedule:

```ruby
class HourlyJob < ApplicationJob
  include ActiveJobCronScheduler::ActiveJobCronScheduler

  schedule_each 1.hour

  def perform(*ignore)
    # Your code here
    puts "Performing hourly job at #{Time.current}"
  end
end
```

### Schedule Options

You can schedule jobs with different intervals:

```ruby

class DailyJob < ApplicationJob
  include ActiveJobCronScheduler::ActiveJobCronScheduler

  schedule_each 1.day, at: "02:00"

  def perform(*ignore)
    # This job will run every day at 2:00 AM
  end
end

class WeeklyJob < ApplicationJob
  include ActiveJobCronScheduler::ActiveJobCronScheduler

  schedule_each 1.week, on: :monday, at: "09:00"

  def perform(*ignore)
    # This job will run every Monday at 9:00 AM
  end
end

class MonthlyJob < ApplicationJob
  include ActiveJobCronScheduler::ActiveJobCronScheduler

  schedule_each 1.month, on: 1, at: "00:00"

  def perform(*ignore)
    # This job will run on the first day of every month at midnight
  end
end
```

### Job Execution

Jobs are automatically scheduled when your Rails application starts. The `ActiveJobCronScheduler::Scheduler` takes care of scheduling all defined jobs.

### Debugging

You can check the `active_job_cron_schedulers` table in your database for information about job executions:

```ruby
ActiveJobCronScheduler::JobRecord.all.each do |record|
  puts "Job: #{record.job}"
  puts "Last execution: #{record.last_execution}"
  puts "---"
end
```

## Configuration

By default, ActiveJobCronScheduler uses your application's default ActiveJob queue adapter. If you want to use a specific adapter for scheduled jobs, you can configure it in an initializer:

```ruby
# config/initializers/active_job_cron_scheduler.rb
Rails.application.config.active_job.queue_adapter = :sidekiq
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yourusername/active_job_cron_scheduler.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).