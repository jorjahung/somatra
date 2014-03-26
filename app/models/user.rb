class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  after_create do |user|
    SOMA.send_new_user(user)
  end

  def gravatar_hash
    Digest::MD5.hexdigest(email)
  end

  def username
    email.match(/^(.+)@/)[1].capitalize
  end
end
