# == Schema Information
#
# Table name: documents
#
#  id         :integer          not null, primary key
#  subject_id :integer          not null
#  class_year :integer          not null
#  code       :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Document, :type => :model do
end
