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
FactoryBot.define do
  factory :author do
    name { "MyString" }
    bio { "MyText" }
    active { false }
  end
end
