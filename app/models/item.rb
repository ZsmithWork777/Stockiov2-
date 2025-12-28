require "csv"

class Item < ApplicationRecord
  belongs_to :category
  belongs_to :user

  after_create  :log_create
  after_update  :log_update
  after_destroy :log_destroy

  def self.to_csv
    CSV.generate(headers: true) do |csv|
      csv << ["id", "name", "quantity", "category_id", "created_at", "updated_at"]

      find_each do |item|
        csv << [
          item.id,
          item.name,
          item.quantity,
          item.category_id,
          item.created_at,
          item.updated_at
        ]
      end
    end
  end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      data = row.to_h.symbolize_keys

      item = Item.find_or_initialize_by(id: data[:id])
      item.update(
        name: data[:name],
        quantity: data[:quantity],
        category_id: data[:category_id]
      )
    end
  end

  private

  def log_create
    AuditLog.log(
      action: "item_create",
      record: self,
      details: {
        name: name,
        quantity: quantity,
        category_id: category_id
      }
    )
  end

  def log_update
    return if previous_changes.empty?

    AuditLog.log(
      action: "item_update",
      record: self,
      details: previous_changes
    )
  end

  def log_destroy
    AuditLog.log(
      action: "item_destroy",
      record: self,
      details: {
        name: name,
        quantity: quantity,
        category_id: category_id
      }
    )
  end
end
