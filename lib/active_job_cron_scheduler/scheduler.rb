# frozen_string_literal: true
require_relative 'active_job_cron_scheduler'
require_relative 'job_record'

module ActiveJobCronScheduler
  class Scheduler
    def self.schedule_all
      Dir[Rails.root.join('app', 'jobs', '**', '*.rb')].each { |file| require_dependency file }
      ActiveJob::Base.descendants.each do |job_class|
        if job_class.include?(ActiveJobCronScheduler)
          # Log as info
          Rails.logger.info "Scheduling ActiveJobCronScheduler #{job_class}"
          job_class.override_and_schedule
        end
      end
    end
  end
end
