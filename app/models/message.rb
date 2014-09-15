class Message < ActiveRecord::Base
  has_and_belongs_to_many :recipients, class_name: 'Contact',
                          join_table: :messages_contacts
  has_many :links
  validates_presence_of :body
  validates_presence_of :recipients
  validates_associated :recipients

  after_create :collect_links

  def send_to_recipients(recips = nil)
    MessageMailer.send_message(self, recips).deliver
  end

  def collect_links
    text_body.scan(Link.url_format).map {|m| m[1] }.flatten.each do |url|
      self.links.create(url: url)
    end
  end

  def text_body
    Nokogiri::HTML(body).xpath("//text()").to_s
  end


end
