class User < ActiveRecord::Base
  include SentientUser
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :id, :username, :firstname, :lastname, :email, :password, :password_confirmation, :remember_me, :user_type_id, :facility_id, :inactive_on, :inactive_comment
  # attr_accessible :title, :body

  belongs_to :user_type
  belongs_to :facility
  has_many :notifications
  has_many :notification_receivers
  has_many :notification_reports
  has_many :pppams_issues

  validates_presence_of :email
  validates_uniqueness_of :email

  delegate :name, to: :user_type, :prefix => true, :allow_nil => true
  delegate :name, to: :facility, :prefix => true, :allow_nil => true

  def is_admin?
    self.user_type.try(:access_level_id) == 1
  end

  def name
    [firstname,lastname].join(" ")
  end
end
