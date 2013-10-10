require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  has_many :urls
  # Remember to create a migration!
  validates :full_name, presence: true
  validates :email, uniqueness: true
  



  def password
      @password ||= Password.new(password_hash)
  end

  def password=(new_password)
      @password = Password.create(new_password)
      self.password_hash = @password
  end

  def create
    @user = User.new(params[:user])
    @user.password = params[:password]
    @user.save!
  end


  def authenticate(input_password)
    self.password == input_password
  end



end
