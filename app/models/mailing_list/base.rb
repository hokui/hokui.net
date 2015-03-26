require 'active_resource'

module MailingList
  class Base < ::ActiveResource::Base
    self.site = "http://#{ENV['mailing_list_host']}/api"
    self.user = ENV['mailing_list_user']
    self.password = ENV['mailing_list_pass']
  end
end
