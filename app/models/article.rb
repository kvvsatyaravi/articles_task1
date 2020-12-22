class Article < ApplicationRecord
  belongs_to :user
  validates :title, presence: true, length: {minimum: 6}
  validates :description, presence: true, length: {minimum: 20}

end
