class IntercomDownload < ApplicationRecord
  include Shrine::Attachment(:file)
end

# == Schema Information
#
# Table name: intercom_downloads
#
#  id         :bigint(8)        not null, primary key
#  file_data  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
