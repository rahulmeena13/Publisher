class Article < ActiveRecord::Base
  belongs_to :user, :inverse_of => :articles
  
   validates_presence_of :title, :body
end
