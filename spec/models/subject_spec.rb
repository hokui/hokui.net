# == Schema Information
#
# Table name: subjects
#
#  id         :integer          not null, primary key
#  title_ja   :string(255)
#  title_en   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Subject, :type => :model do
end
