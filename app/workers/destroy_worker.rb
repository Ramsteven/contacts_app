class DestroyWorker 
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(user_id)
    user = User.find(user_id)
    user.contacts.destroy_all
    user.attacheds.destroy_all
    user.fail_contacts.destroy_all
  end
end
