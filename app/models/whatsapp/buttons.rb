class Whatsapp::Buttons
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :text, :string
  attribute :id, :string

  def build
    {
      type: 'reply',
      reply: {
        id: id,
        title: text
      }
    }
  end
end
