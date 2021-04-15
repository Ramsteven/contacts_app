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

  # def self.my_import(file, current_user)
  def import
      user = User.find(user_id)
      value = 0
      convert = JSON.parse match.gsub("=>", ":")
      table = CSV.parse(attached_csv.download, headers: true, header_converters: lambda { |name| convert[name] })

      table.each do |row| 
        @import_contacts = user.contacts.new row.to_h
        unless @import_contacts.save
          @import_failed = user.fail_contacts.new row.to_h
          @import_failed.message = @import_contacts.errors.full_messages
          @import_failed.save
        else
          value = 1
        end
      end
      if value == 1
          status = user.attacheds.find(id)
          status.status = "finish"
          status.save
        else
          status = user.attacheds.find(id)
          status.status = "failed"
          status.save
        end
     end
 end
