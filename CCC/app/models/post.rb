class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :files
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 10000}
  #validates :file, content_type: { in: %w[], message: "Deve essere un formato di file valido" }, size: {less_than: 300.megabytes, message: "Deve essere minore di 300MB"}
end
