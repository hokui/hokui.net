# == Schema Information
#
# Table name: semesters
#
#  id            :integer          not null, primary key
#  class_year_id :integer          not null
#  identifier    :string           not null
#  created_at    :datetime
#  updated_at    :datetime
#

require 'rails_helper'

RSpec.describe Semester, :type => :model do
end
