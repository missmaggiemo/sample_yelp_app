
class Business < ActiveRecord::Base
  
  has_one :location
  
  has_many :ratings
  
  has_many :yelp_reviews
  
  def rating
    unless self.ratings.empty?
      self.ratings.map(&:stars).inject(&:+) / self.ratings.length.to_f
    end 
  end

  
  def self.yelp_businesses_json_to_businesses(yelp_businesses_json)    
    yelp_businesses_json.each.with_object([]) do |business_json, business_arr|
      business_arr << json_to_business(business_json)
      Location.json_to_location(business_arr.last.id, business_json['location'])
    end
  end
  
  def self.json_to_business(json)    
    new_biz = Business.new(
      name: json["name"],
      review_count: json["review_count"],
      yelp_rating: json["rating"],
      display_phone: json["display_phone"],
      url: json["url"],
      image_url: json["image_url"],
      snippet_text: json["snippet_text"],
      id_string: json["id"]
    )
      
    # this could all be totally broken because I can't test it right now
    unless biz = Business.find_by(id_string: new_biz.id_string)
      new_biz.save!
    end
    biz || new_biz
  end
  
end


