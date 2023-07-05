class TrainingLog < ApplicationRecord
  belongs_to :user

  validates :training_menu, :step, :repetition, :set, presence: true
  validates :memo, length: { maximum: 200 }
end