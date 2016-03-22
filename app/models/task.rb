class Task < ActiveRecord::Base

  validates :name, presence: true, length: { minimum: 5, maximum: 50}
  validates :due_date, presence: true

  belongs_to :user


end
