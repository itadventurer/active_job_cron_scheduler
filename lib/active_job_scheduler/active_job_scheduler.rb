# frozen_string_literal: true

module ActiveJobScheduler
  module ActiveJobScheduler
    extend ActiveSupport::Concern

    included do
      before_perform do |job|
        self.class.check_singleton_token(job.arguments.first[:singleton_token])
      end
      after_perform do |job|
        self.class.schedule_next
      end
    end

    class_methods do
      def schedule_each(interval, options = {})
        @interval = interval
        @schedule_options = options
      end

      def schedule_next
        job_record = find_or_create_job_record
        job_record.update(last_execution: Time.current)
        next_run = calculate_next_run(job_record)
        set(wait_until: next_run).perform_later(singleton_token: job_record.singleton_token)
      end

      def override_and_schedule
        job_record = find_or_create_job_record
        job_record.update(singleton_token: SecureRandom.uuid)
        next_run = calculate_next_run(job_record)
        set(wait_until: next_run).perform_later(singleton_token: job_record.singleton_token)
      end

      def find_or_create_job_record
        JobRecord.find_or_create_by(job: name) do |record|
          record.singleton_token = SecureRandom.uuid
        end
      end

      def check_singleton_token(singleton_token)
        job_record = find_or_create_job_record
        if job_record.singleton_token != singleton_token
          logger.info "Job #{self.class.name} skipped: mismatched singleton token"
          throw :abort
        end
      end

      private

      def calculate_next_run(job_record)
        case @interval
        when ActiveSupport::Duration
          if job_record.last_execution.nil?
            Time.current
          else
            job_record.last_execution + @interval
          end
        else
          raise ArgumentError, "Unsupported interval type"
        end
      end

    end
  end
end
