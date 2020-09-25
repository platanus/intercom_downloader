class DownloadDataJob < ApplicationJob
  queue_as :default

  def perform(intercom_token)
    json = IntercomService.new(token: intercom_token).download_conversations().to_json
    file = StringIO.new(json)
    IntercomDownload.create!(file: file)
  end
end
