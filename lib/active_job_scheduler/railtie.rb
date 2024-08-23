# frozen_string_literal: true

module ActiveJobScheduler
  class Railtie < Rails::Railtie
    initializer 'active_job_scheduler.initialize' do
      Rails.application.config.after_initialize do
        if Rails.env.development? || Rails.env.production?
          if defined?(Rails::Server)
            Scheduler.schedule_all
          end
        end
      end
    end
  end
end