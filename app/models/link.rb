class Link < ActiveRecord::Base
  belongs_to :message
  validates_presence_of :url

  def self.url_format
    /(^|\s)((https?:\/\/)?[\w-]+(\.[\w-]+)+\.?(:\d+)?(\/\S*)?)/i
  end

end
