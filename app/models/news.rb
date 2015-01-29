# == Schema Information
#
# Table name: news
#
#  id         :integer          not null, primary key
#  text       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string
#

class News < ActiveRecord::Base
  validates(:text) { presence }
end
