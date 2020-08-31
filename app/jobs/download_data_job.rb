class DownloadDataJob < ApplicationJob
  queue_as :default

  def perform(intercom_token)
    json = { some_key: 'some_value' }.to_json
    file = StringIO.new(json)
    IntercomDownload.create!(file: file)
  end
end
