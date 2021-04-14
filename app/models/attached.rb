require 'csv'
class Attached < ApplicationRecord
  belongs_to :user
  has_one_attached :attached_csv
  
  

  def self.name_headers(file, convert)
    byebug
    CSV.foreach(file.path, headers: ["pipiolo", "gumercindo", "donato", "peluo", "calabazo", "elotro"]) do |row|
    byebug
    end
  end
end
