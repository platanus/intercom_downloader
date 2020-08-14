class DownloadDataJob < ApplicationJob
  queue_as :default

  def perform(intercom_token)
    logger.info('ran job with token ' + intercom_token)
  end
end
