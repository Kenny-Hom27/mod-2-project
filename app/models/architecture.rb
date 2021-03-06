class Architecture < ApplicationRecord
  belongs_to :city
  belongs_to :artist
  belongs_to :style
  has_many :reviews

  validates :name, uniqueness: true, presence: true
  validates :name, length: { minimum: 3}
  validates :name, length: { maximum: 20}
  
  def artist_name
    self.artist.name
  end

  def city_name
    self.city.name
  end

  def style_name
    self.style.name
  end

  def title
    self.name.titleize
  end

  def self.sorted
    Architecture.all.sort_by {|arc| arc.name}
  end

  def self.most_reviewed
    @architecture = Architecture.all.max_by do |arc|
      arc.reviews.count
    end
    "#{@architecture.name}:   " + @architecture.reviews.count.to_s
  end

  def average_rating
    @ratings = self.reviews.map { |review| review.rating.to_f }
    @average = @ratings.reduce(:+) / @ratings.count
  end



end
