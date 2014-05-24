
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
 has_many :ratings

 has_many :favorites
 
 has_many :saved_searches
 
 def favorites
   Favorite.where(user_id: self.id).order(created_at: :desc)
 end

 def ratings
   Rating.where(user_id: self.id).order(created_at: :desc)
 end
 
 def recent_ratings
   Rating.where(user_id: self.id).order(created_at: :desc).limit(10)   
 end
 
 def recent_searches
   SavedSearch.where(user_id: self.id).order(created_at: :desc).limit(10)
 end


 
end
