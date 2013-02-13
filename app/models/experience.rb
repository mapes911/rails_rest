class Experience < ActiveRecord::Base
  attr_accessible :title, :moral
  belongs_to :user
  has_many :chapters, dependent: :destroy

  # filters
  before_create :create_slug

  # validation
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 300 }
  validates :moral, presence: true, length: { maximum: 300 }

  def create_slug
    # dunno if this is the right way to go yet. will tackle this after.
    # self.slug = self.title.parameterize
  end

  def chapter_list
    Chapter.where("experience_id = ?", id)
  end

end