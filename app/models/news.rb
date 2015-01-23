class News < ActiveRecord::Base
  validates(:text) { presence }
end
