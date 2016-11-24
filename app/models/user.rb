class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :omniauthable
  include DeviseTokenAuth::Concerns::User

  has_many :borrowed_books, class_name: "Book", foreign_key: "subscriber_id"
  has_many :owned_books, class_name: "Book", foreign_key: "owner_id"
  has_many :penalties
  has_many :reviews

before_validation do
  self.uid = email if uid.blank?  
  self.approved = false if self.approved.nil?
end

before_save -> { skip_confirmation! }

def name
	[first_name,last_name].join(' ')
end

def points_calculation(ammount)
  self.points = self.points - ammount
  self.save
end

def borrow_times_increment
  self.borrow_times = self.borrow_times + 1
  self.save
end

end
