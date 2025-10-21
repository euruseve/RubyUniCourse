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
require 'rails_helper'

RSpec.describe Author, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
