# == Schema Information
#
# Table name: access_tokens
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  token            :string(255)      not null
#  last_activity_at :datetime
#  created_at       :datetime
#  updated_at       :datetime
#

class AccessToken < ActiveRecord::Base
end
