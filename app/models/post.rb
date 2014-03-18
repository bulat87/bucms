class Post < ActiveRecord::Base

  validates :slug, uniqueness: true, presence: true

  before_validation :generate_slug

  belongs_to :user
  has_many :comments, :dependent => :destroy
  acts_as_taggable


  def to_param
    slug
  end

  def generate_slug
    self.slug ||= title.parameterize
  end
end
