class Message < ActiveRecord::Base
  has_and_belongs_to_many :recipients, class_name: 'Contact',
                          join_table: :messages_contacts
  has_many :links
  belongs_to :user

  validates_presence_of :body
  validates_presence_of :recipients
  validates_presence_of :user
  validates_associated :recipients, :user

  after_create :collect_links

  def send_to_recipients(recips = nil)
    MessageMailer.send_message(self, recips).deliver
  end

  def collect_links
    Nokogiri::HTML(body).xpath("//body//a").each do |link|
      self.links.create(url: link['href'] || '')
    end
  end

  def text_body
    Nokogiri::HTML(body).xpath("//text()").to_s
  end


end
