module ApplicationHelper
  def audit_action_color(action)
    case action
    when "create", "api_create"
      "text-green-600"
    when "update", "api_update"
      "text-blue-600"
    when "delete", "destroy", "api_delete"
      "text-red-600"
    else
      "text-gray-600"
    end
  end
end
