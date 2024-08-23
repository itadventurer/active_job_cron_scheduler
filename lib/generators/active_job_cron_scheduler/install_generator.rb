# frozen_string_literal: true

require 'rails/generators'
require 'rails/generators/migration'

module ActiveJobCronScheduler
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path('templates', __dir__)

      def self.next_migration_number(dirname)
        next_migration_number = current_migration_number(dirname) + 1
        ActiveRecord::Migration.next_migration_number(next_migration_number)
      end

      def create_migration_file
        migration_template 'create_active_job_schedules.rb', 'db/migrate/create_active_job_schedules.rb'
      end
    end
  end
end