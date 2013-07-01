class Article < ActiveRecord::Base
  belongs_to :user, :inverse_of => :articles
end
