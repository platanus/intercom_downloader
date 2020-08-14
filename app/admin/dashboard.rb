ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  page_action :trigger, method: :post do
    DownloadDataJob.perform_later params['intercom_token']
    redirect_to "/"
  end

  controller do
    skip_before_action :verify_authenticity_token, only: [:trigger]
  end

  content do
    form action: "admin/dashboard/trigger", method: :post do |f|
      div "Token de intercom"
      f.input :intercom_token, type: :text, name: 'intercom_token'
      f.input :submit, type: :submit
    end
  end
end
