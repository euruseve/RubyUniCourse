# == Schema Information
#
# Table name: authors
#
#  id         :bigint           not null, primary key
#  active     :boolean          default(TRUE), not null
#  bio        :text
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_authors_on_active  (active)
#  index_authors_on_name    (name)
#
class Author < ApplicationRecord
  has_many :books, dependent: :restrict_with_error

  validates :name, presence: true
  validates :active, inclusion: { in: [true, false] }

  scope :active, -> { where(active: true) }

  scope :ordered_by_name, -> { order(:name) }

  delegate :count, to: :books, prefix: true
end
