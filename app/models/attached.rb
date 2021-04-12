class Attached < ApplicationRecord
  belongs_to :user
  has_one_attached :attached_csv

  #def self.my_import(file, current_user)
  #    attacheds = []
  #    CSV.foreach(file.path, headers: true) do |row| 
  #      current_user.attacheds.create! row.to_h 
  #      #contacts << current_user.contacts.new(row.to_h)
  #    end
  # end
end
