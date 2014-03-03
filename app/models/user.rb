class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, 
        :trackable, :validatable, :rememberable, :timeoutable,
        :registerable
  attr_accessible :email, :password, :password_confirmation
end
