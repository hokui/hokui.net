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

class Subject < ActiveRecord::Base
  validates(:title_ja) { presence; uniqueness }
  validates(:title_en) { presence; uniqueness; format(with: /\A[0-9a-z_]+\Z/) }
end
