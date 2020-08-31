ActiveAdmin.register IntercomDownload do
  config.filters = false
  actions :index, :destroy

  member_action :download, method: :get do
    intercom_download = IntercomDownload.find(params[:id])
    send_file intercom_download.file.download
  end

  index do
    column :id
    column :created_at
    column do |intercom_download|
      link_to('Descargar', download_intercom_download_path(intercom_download))
    end
    actions
  end
end
