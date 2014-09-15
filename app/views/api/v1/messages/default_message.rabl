attribute :id
attribute :subject
attribute :body
attribute :created_at
attribute :updated_at
node(:recipients) { |msg| msg.recipients.map(&:email) }
node(:link_count) { |msg| msg.links.length }