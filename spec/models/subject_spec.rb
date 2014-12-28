# == Schema Information
#
# Table name: subjects
#
#  id         :integer          not null, primary key
#  title_ja   :string           not null
#  title_en   :string           not null
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe Subject, :type => :model do
end
