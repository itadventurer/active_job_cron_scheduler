# frozen_string_literal: true

class CreateActiveJobSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :active_job_schedules, id: false do |t|
      t.string :job, null: false, primary_key: true
      t.datetime :last_execution
      t.string :singleton_token

      t.timestamps
    end
  end
end