class ContactForm
  include ActiveModel::Validations

  validates_presence_of :recipient, :subject, :body
  validates_format_of   :recipient, :with => /\b[a-z0-9._%-]+@[a-z0-9.-]+\.[a-z]{2,4}\b/i
  validates_length_of   :body, :minimum => 10

  attr_accessor :recipient, :subject, :body

  def initialize(attributes = {})
    @recipient  = attributes[:recipient]
    @body       = attributes[:body]
    @subject    = attributes[:subject]

    yield(self) if block_given?
  end
end
