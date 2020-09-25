class IntercomService < PowerTypes::Service.new(:token)
  # Service code goes here

  def create_contact(email)
    intercom_client.contacts.create(email: email, role: "lead")
  end

  def download_conversations
    intercom_client.conversations.all.map do |convo|
      conversation = intercom.conversations.find(id: convo.id)
      {
        id: conversation.id,
        created_at: conversation.created_at,
        tags: conversation.tags,
        conversation_parts: conversation.conversation_parts.map do |part|
          {
            body: part.body,
            id: part.id,
            author_type: part.author_type
          }
        end
      }
    end
  end

  private

  def intercom_client
    @intercom_client ||= Intercom::Client.new(token: @token, api_version: '2.2')
  end
end
