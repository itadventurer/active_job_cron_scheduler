# frozen_string_literal: true

module ActiveJobScheduler
  class JobRecord < ActiveRecord::Base
    self.table_name = 'active_job_schedules'
  end
end