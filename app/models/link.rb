class Link < ActiveRecord::Base
  belongs_to :message
  validates :url, presence: true,
            format: self.url_format

  def self.url_format
    /(^|\s)((https?:\/\/)?[\w-]+(\.[\w-]+)+\.?(:\d+)?(\/\S*)?)/i
  end
end
