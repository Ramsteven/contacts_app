class ImportWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
  def perform(id)
    attached_csv = Attached.find(id)
    attached_csv.status = "Processing"
    attached_csv.save
    attached_csv.import
  end
end
