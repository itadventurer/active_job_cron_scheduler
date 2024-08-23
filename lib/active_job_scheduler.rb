# frozen_string_literal: true
require 'active_job_scheduler/railtie' if defined?(Rails)
require 'active_job_scheduler/active_job_scheduler'
require 'active_job_scheduler/scheduler'
require 'active_job_scheduler/job_record'

module ActiveJobScheduler
  class Error < StandardError; end
end

