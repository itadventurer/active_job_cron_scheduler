# frozen_string_literal: true

module ActiveJobCronScheduler
  class JobRecord < ActiveRecord::Base
    self.table_name = 'active_job_schedules'
  end
end