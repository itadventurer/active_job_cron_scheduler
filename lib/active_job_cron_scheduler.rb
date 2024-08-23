# frozen_string_literal: true
require 'active_job_cron_scheduler/railtie' if defined?(Rails)
require 'active_job_cron_scheduler/active_job_cron_scheduler'
require 'active_job_cron_scheduler/scheduler'
require 'active_job_cron_scheduler/job_record'

module ActiveJobCronScheduler
  class Error < StandardError; end
end

