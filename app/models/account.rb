class Account < ApplicationRecord

	belongs_to :user

	validates :balance, numericality: {greater_than: 0}
end
