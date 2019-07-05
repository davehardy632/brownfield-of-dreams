class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: %i[default admin]
  has_secure_password


  def from_omniauth(auth_info)
    auth_info["credentials"]["token"]
  end
end
# create_table "users", force: :cascade do |t|
#   t.string "email"
#   t.string "first_name"
#   t.string "last_name"
#   t.string "password_digest"
#   t.integer "role", default: 0
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.string "token"
#   t.index ["email"], name: "index_users_on_email"
# end
