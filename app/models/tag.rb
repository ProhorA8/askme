class Tag < ApplicationRecord
  TAG_REGEX = /#[[:alpha:]-]+/.freeze

  has_many :tag_questions
  has_many :questions, through: :tag_questions

  scope :with_questions, -> { joins(:questions).distinct }

  before_validation { name&.downcase! }

  validates :name, presence: true

  def to_param
    name
  end
end
