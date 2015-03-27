require 'active_resource'

module MailingList
  class Base < ::ActiveResource::Base
    class MLResourceInvalid < StandardError
      attr_reader :record

      def initialize(record)
        @record = record
        errors = @record.errors.full_messages.join(", ")
        super(errors)
      end
    end

    self.site = "http://#{ENV['mailing_list_host']}/api"
    self.user = ENV['mailing_list_user']
    self.password = ENV['mailing_list_pass']

    def self.create!(attributes = {})
      self.create(attributes).tap do |resource|
        raise MLResourceInvalid.new(resource) unless resource.persisted?
      end
    end
  end
end
