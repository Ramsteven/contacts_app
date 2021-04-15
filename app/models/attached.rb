require 'csv'
class ContentTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.attached? && value.content_type.in?(content_types)
      value.purge if record.new_record? # Only purge the offending blob if the record is new
      record.errors.add(attribute, "is not a valid file format", options)
    end

    unless record.attached_csv.attached?
      record.errors.add(attribute, "Plese attach an file CSV", options)
    end
  end

  private

  def content_types
    options.fetch(:in)
  end
end

class Attached < ApplicationRecord
  belongs_to :user
  has_one_attached :attached_csv, dependent: :destroy
  
  

  validates :name, presence: true
  validates :attached_csv, content_type: ["text/csv"]
  validates :match, presence: true
  validates :headers_csv, numericality: { only_integer: true, equal_to: 6}

  def self.my_import(file, current_user)
    byebug
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
