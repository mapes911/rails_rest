class Chapter < ActiveRecord::Base
  attr_accessible :body, :title
  belongs_to :experience

  # validation
  validates :experience_id, presence: true
  validates :title, presence: true, length: { maximum: 300 }
  validates :body, presence: true

end