class EncryptionService
 KEY = ActiveSupport::KeyGenerator.new( 
  Rails.application.credentials[Rails.env.to_sym][:encrypt][:key_encrypt]
  ).generate_key(
    SecureRandom.random_bytes(
    ActiveSupport::MessageEncryptor.key_len
  ),
    ActiveSupport::MessageEncryptor.key_len
  ).freeze 

  # KEY = ActiveSupport::KeyGenerator.new(
  #   ENV.fetch("SECRET_KEY_BASE")
  # ).generate_key(
  #   ENV.fetch("ENCRYPTION_SERVICE_SALT"),
  #   ActiveSupport::MessageEncryptor.key_len
  # ).freeze


  private_constant :KEY

  delegate :encrypt_and_sign, :decrypt_and_verify, to: :encryptor

  def self.encrypt(value)
    new.encrypt_and_sign(value)
  end

  def self.decrypt(value)
    new.decrypt_and_verify(value)
  end

  private

  def encryptor
    ActiveSupport::MessageEncryptor.new(KEY)
  end
end

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

    if email_validate( User.find(record[:user_id]).contacts, value) #momentanily User.first => replace after with current_user
      record.errors.add attribute, (options[:message] || "Currently exist's an contact with this email")
      byebug
    end
  end

   private
  #function that check contacts array and model Employee 
  #for discard employees with repetead email
  def email_validate(contacts, current_email) 
     if contacts.where(email: current_email).present?
       return true
     end
    false
  end 
end

class BirthDateValidator < ActiveModel::Validator
  def validate(record)
    date_iso8601 = ["%F", "%Y%m%d"]
    date_birth = record.send(:birth_date_before_type_cast)
    value = ""
      begin
        value = Time.strptime(date_birth, date_iso8601[0])
      rescue ArgumentError
         begin
          value = Time.strptime(date_birth, date_iso8601[1])
         rescue ArgumentError
            record.errors.add(:birth_date, "This format is not valid olny acepts %Y%m%d and %F")
          end
      end
      record[:birth_date] = date_birth
      
      if record[:birth_date].nil?
            record.errors.add(:birth_date, "This format is not valid olny acepts %Y%m%d and %F")
      end
  end
end

class Contact < ApplicationRecord
  belongs_to :user
 # before_save -> { self[:credit_card] = BCrypt::Password.create( self[:credit_card] , :cost => 10) }
  before_save  -> { self[:credit_card] = api_token_cryp(self[:credit_card])}

  attr_accessor :current_user
  VALID_FULLNAME_REGEX =/\A[a-zA-Z- ]+\z/
  VALID_PHONE_REGEX =/\A\(\+\d{2}\) \d{3}([ -])\d{3}\1\d{2}\1\d{2}\z/
  

  validates :fullname, presence: true, format: { with: VALID_FULLNAME_REGEX , message: "only allows letters" }
  validates_with BirthDateValidator, attributes: [:birth_date]
  validates :phone, presence: true, presence: true, format: { with: VALID_PHONE_REGEX}
  validates :address, presence: true
  validates :credit_card, presence: true, credit_card: true
  validates :franchise, presence: true
  validates :email, presence: true, email: true

  def api_token
    EncryptionService.decrypt(encrypted_api_token)
    #EncryptionService.decrypt("diVs6uL/XCC7QsqT2Xm7OeEFzQ+TYuxZ0wg=--VZ25034HLJUqtUKu--pu3r03XuWImFDNO579+OlQ==").last(4)
  end

  def api_token_cryp(value)
    encrypted_api_token = EncryptionService.encrypt(value)
  end
end
