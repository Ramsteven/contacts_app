class EncryptionService
 KEY = ActiveSupport::KeyGenerator.new( 
  Rails.application.credentials[Rails.env.to_sym][:encrypt][:key_encrypt]
  ).generate_key(
    SecureRandom.random_bytes(
    ActiveSupport::MessageEncryptor.key_len
  ),
    ActiveSupport::MessageEncryptor.key_len
  ).freeze 

  private_constant :KEY

  delegate :encrypt_and_sign, :decrypt_and_verify, to: :encryptor

  def self.encrypt(value)
    result = new.encrypt_and_sign(value[0..-5])
    result += value[-4..-1]
  end

  # def self.decrypt(value)
  #   new.decrypt_and_verify(value)
  # end

  private

  def encryptor
    ActiveSupport::MessageEncryptor.new(KEY)
  end
end

class FailContact < ApplicationRecord
  belongs_to :user
  before_save  -> { self[:credit_card] = self[:credit_card][0..-5] = "XXXXXXXX"+ self[:credit_card][-4..-1]}
end
