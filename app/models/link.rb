class Link < ActiveRecord::Base
  belongs_to :message
  validate :precense_and_format

  def self.url_format
    /(^|\s)((https?:\/\/)?[\w-]+(\.[\w-]+)+\.?(:\d+)?(\/\S*)?)/i
  end

  private
    def precense_and_format
      if url.nil? || url.match(Link.url_format).nil?
        errors.add(:url, "URL required to be in the correct format")
      end
    end
end
