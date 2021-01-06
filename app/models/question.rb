class Question < ApplicationRecord
  belongs_to :user
  belongs_to :author, class_name: 'User', optional: true

  has_many :tag_questions, dependent: :destroy
  has_many :tags, through: :tag_questions

  validates :text, presence: true, length: { maximum: 255 }

  after_commit :update_tags, on: %i[create update]

  private

  def update_tags
    tag_questions.clear # чистим связи
    "#{text} #{answer}".downcase.scan(Tag::TAG_REGEX).uniq.each do |tag|
      tags << Tag.find_or_create_by(name: tag.delete('#'))
    end
  end
end
