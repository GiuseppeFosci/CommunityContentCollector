class Post < ApplicationRecord
  belongs_to :user
  has_many_attached :files
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: 10000}
  validates :files, content_type: { in: %w[application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document text/x-python text/x-c++src text/x-java-source text/x-ruby], message: "Deve essere un formato di file valido" }, size: {less_than: 300.megabytes, message: "Deve essere minore di 300MB"}
end
