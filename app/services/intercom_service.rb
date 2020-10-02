class IntercomService < PowerTypes::Service.new(:token)
  def download_conversations
    conversations = []
    intercom_client.conversations.all.each do |convo|
      conversations << get_single_conversation(convo)
    end
    conversations
  rescue StandardError
    conversations
  end

  def generate_fake_leads
    return unless Rails.env.development?

    10.times do |i|
      create_contact "fake_dude_#{i}@platan.us"
    end
  end

  def generate_fake_messages
    return unless Rails.env.development?

    contacts = intercom_client.contacts.all
    contacts.each do |ct|
      intercom_client.messages.create(
        {
          from: {
            type: "contact",
            id: ct.id
          },
          body: "halp me pls"
        }
      )
    end
  end

  private

  def get_single_conversation(convo)
    conversation = intercom_client.conversations.find(id: convo.id)
    {
      id: conversation.id,
      created_at: conversation.created_at,
      tags: conversation.tags,
      conversation_parts: parse_conversation_parts
    }
  end

  def parse_conversation_parts
    conversation_parts = [{
      body: conversation.source.body,
      id: conversation.source.id,
      author_type: conversation.source.author.type,
      created_at: conversation.created_at
    }]
    conversation.conversation_parts.each do |part|
      if part.body
        conversation_parts << {
          body: part.body,
          id: part.id,
          author_type: part.author.type,
          created_at: part.created_at
        }
      end
    end
    conversation_parts
  end

  def create_contact(email)
    intercom_client.contacts.create(email: email, role: "lead")
  end

  def intercom_client
    @intercom_client ||= Intercom::Client.new(
      token: @token,
      api_version: '2.2',
      handle_rate_limit: true
    )
  end
end
