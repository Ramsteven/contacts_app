class AddColumnToAttached < ActiveRecord::Migration[6.1]
  def change
    add_column :attacheds, :headers_csv, :integer
  end
end
