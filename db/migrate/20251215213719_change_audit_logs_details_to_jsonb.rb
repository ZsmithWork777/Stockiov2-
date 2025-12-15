class ChangeAuditLogsDetailsToJsonb < ActiveRecord::Migration[8.0]
  def up
    # Remove incompatible legacy data
    execute "UPDATE audit_logs SET details = NULL"

    # Explicitly cast column to jsonb
    change_column :audit_logs, :details, :jsonb, using: 'details::jsonb'
  end

  def down
    change_column :audit_logs, :details, :text
  end
end
