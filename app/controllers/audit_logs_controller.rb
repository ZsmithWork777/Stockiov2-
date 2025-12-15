class AuditLogsController < ApplicationController
  def index
    @audit_logs = AuditLog.order(created_at: :desc)
  end
end
