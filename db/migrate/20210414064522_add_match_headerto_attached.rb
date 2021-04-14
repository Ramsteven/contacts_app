class AddMatchHeadertoAttached < ActiveRecord::Migration[6.1]
  def change
    add_column :attacheds, :match, :text
    add_column :attacheds, :name, :string
  end
end
