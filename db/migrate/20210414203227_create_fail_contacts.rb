class CreateFailContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :fail_contacts do |t|
      t.string :message
      t.string :fullname
      t.string :email
      t.string :phone
      t.string :address
      t.string :birth_date
      t.string :credit_card
      t.references :user, null: false, foreign_key: true
      t.string :franchise

      t.timestamps
    end
  end
end
