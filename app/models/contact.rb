class Contact < ApplicationRecord
  include Discard::Model

  validates :first_name, :last_name, :email, presence: true
end
