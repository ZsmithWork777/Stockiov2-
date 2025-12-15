class AuditLog < ApplicationRecord
  def self.log(action:, record:, details: nil)
    return unless record

    create!(
      action: action,
      record_type: record.class.name,
      record_id: record.id,
      details: details.is_a?(Hash) ? details : details
    )
  end
end
