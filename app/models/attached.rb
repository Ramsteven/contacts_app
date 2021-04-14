require 'csv'
class Attached < ApplicationRecord
  belongs_to :user
  has_one_attached :attached_csv
  

  def self.my_import(file, current_user)
    byebug
      contacts = []
      value = 0
      convert = JSON.parse file.match.gsub("=>", ":")
      table = CSV.parse(file.attached_csv.download, headers: true, header_converters: lambda { |name| convert[name] })
      table.each do |row| 

       # if email_validate(contacts, row[1], current_user)
       #     next 
       # end
        byebug
        @import_contacts = current_user.contacts.new row.to_h
        unless @import_contacts.save
          @import_failed = current_user.fail_contacts.new row.to_h
          @import_failed.message = @import_contacts.errors.full_messages
          @import_failed.save
        else
          value = 1
        end
        if value == 1
          file.status = "finish"
          file.save
        else
          file.status = "failed"
          file.save
        end
      end
    end

end
