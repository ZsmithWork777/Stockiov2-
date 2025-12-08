require "csv"

class Item < ApplicationRecord
  belongs_to :category
 #CSV EXPORT
  def self.to_csv
    CSV.generate(headers: true) do |csv|
    csv << ["id", "name", "quantity", "category_id", "created_at", "updated_at"]

all.find_each do |item|
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
# CSV IMPORT

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
end
