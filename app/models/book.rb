# == Schema Information
#
# Table name: books
#
#  id          :bigint           not null, primary key
#  author      :string
#  description :text
#  title       :string
#  year        :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  author_id   :bigint
#
# Indexes
#
#  index_books_on_author_id  (author_id)
#
# Foreign Keys
#
#  fk_rails_...  (author_id => authors.id)
#
class Book < ApplicationRecord
  belongs_to :author, optional: true

  validates :title, presence: true
  validates :author_name, presence: true
  validates :year, presence: true,
                   numericality: { only_integer: true,
                                   greater_than_or_equal_to: 1900,
                                   less_than_or_equal_to: 2030 }

  scope :by_title, ->(title) { where('title ILIKE ?', "%#{title}%") if title.present? }
  scope :by_author_name, ->(author) { where('author ILIKE ?', "%#{author}%") if author.present? }
  scope :sorted_by, lambda { |sort_option|
    case sort_option
    when 'title_asc'
      order(title: :asc)
    when 'title_desc'
      order(title: :desc)
    when 'year_asc'
      order(year: :asc)
    when 'year_desc'
      order(year: :desc)
    else
      order(created_at: :desc)
    end
  }

  delegate :name, to: :author, prefix: true, allow_nil: true
end
