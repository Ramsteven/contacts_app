require 'bcrypt'

class CreditCardValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
      unless value =~ /\A[0-9]*\z/
        record.errors.add attribute, (options[:message] || "is not credit_card number")
      end
      record.franchise = valid_association?(value)

      unless record.franchise
        record.errors.add attribute, (options[:message] || "this number dont have any franchise valid")
      end
  end

  def valid_association?(number)
    #validation franchise
    dinersRegex = /^54/
    dinersInternationalRegex = /^36/
    amexRegex = /^3[47]/ 
    visaRegex = /^4/
    masterRegex = /^5[1-5][0-9]{14}|^(222[1-9]|22[3-9]\\d|2[3-6]\\d{2}|27[0-1]\\d|2720)[0-9]{12}$/
    discoverRegex = /^(6011|622(1(2[6-9]|[3-9]\d)|[2-8]\d{2}|9([01]\d|2[0-5]))|64[4-9]|65)/ 
    jbcRegex = /^(?:352[89]|35[3-8][0-9])/

    number = number.to_s.gsub(/\D/, "") 

    return :dinners         if number.length == 16 && number =~ dinersRegex                           # 54xxxx 36xxxx
    return :dinners_inter   if number.length.between?(14,19) && number =~ dinersInternationalRegex   # 36xxxx only international
    return :amex            if number.length == 15 && number =~ amexRegex                              # 34xxxx, 37xxxx
    return :visa            if number.length.between?(13,16) && number =~ visaRegex                    # 4xxxxx
    return :master          if number.length == 16 && number =~ masterRegex                            # 2221xxx-2720xxx 51xxx–55xxx
    return :discover        if number.length.between?(16,19) && number =~ discoverRegex                # 6011xx 622126x-622925x 644x-646x 65x
    return :jbc             if number.length.between?(16,19) && number =~ jbcRegex                     # 3528xx-3589xx
    return nil
  end
 end

class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors.add attribute, (options[:message] || "is not an email")
    end

    if email_validate(User.first.contacts, value) #momentanily User.first => replace after with current_user
      record.errors.add attribute, (options[:message] || "Currently exist's an contact with this email")
    end
  end

   private
  #function that check contacts array and model Employee 
  #for discard employees with repetead email
  def email_validate(contacts, current_email) 
    i=0
    while i <= contacts.length
      begin
        if contacts[i][:email] == current_email
          return true
        end
      rescue => e
      end
      
    #  if Contact.where(email: current_email).present?
    #    return true
    #  end
      i+=1
    end 
    false
  end

end


class Contact < ApplicationRecord
  belongs_to :user
  before_save -> { self[:credit_card] = BCrypt::Password.create( self[:credit_card] , :cost => 10) }

  VALID_BIRTH_DATE_REGEX = /\A(?:(?=[02468][048]00|[13579][26]00|[0-9][0-9]0[48]|[0-9][0-9][2468][048]|[0-9][0-9][13579][26])\d{4}(?:(-|)(?:(?:00[1-9]|0[1-9][0-9]|[1-2][0-9][0-9]|3[0-5][0-9]|36[0-6])|(?:01|03|05|07|08|10|12)(?:\1(?:0[1-9]|[12][0-9]|3[01]))?|(?:04|06|09|11)(?:\1(?:0[1-9]|[12][0-9]|30))?|02(?:\1(?:0[1-9]|[12][0-9]))?|W(?:0[1-9]|[1-4][0-9]|5[0-3])(?:\1[1-7])?))?)$|^(?:(?![02468][048]00|[13579][26]00|[0-9][0-9]0[48]|[0-9][0-9][2468][048]|[0-9][0-9][13579][26])\d{4}(?:(-|)(?:(?:00[1-9]|0[1-9][0-9]|[1-2][0-9][0-9]|3[0-5][0-9]|36[0-5])|(?:01|03|05|07|08|10|12)(?:\2(?:0[1-9]|[12][0-9]|3[01]))?|(?:04|06|09|11)(?:\2(?:0[1-9]|[12][0-9]|30))?|(?:02)(?:\2(?:0[1-9]|1[0-9]|2[0-8]))?|W(?:0[1-9]|[1-4][0-9]|5[0-3])(?:\2[1-7])?))?)\z/
  VALID_FULLNAME_REGEX = /\A[a-zA-Z-]+\z/
  VALID_PHONE_REGEX = /\A\(\+\d{2}\) \d{3}([ -])\d{3}\1\d{2}\1\d{2}\z/
  

  validates :fullname, presence: true, format: { with: VALID_FULLNAME_REGEX , message: "only allows letters" }
  validates :birth_date, presence: true,  format: { with: VALID_BIRTH_DATE_REGEX , message: "The format should be Year/Month/Day" }
  validates :phone, presence: true, presence: true, format: { with: VALID_PHONE_REGEX}
  validates :address, presence: true
  validates :credit_card, presence: true, credit_card: true
  validates :franchise, presence: true
  validates :email, presence: true, email: true

  private

end
