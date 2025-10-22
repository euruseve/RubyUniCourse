# == Schema Information
#
# Table name: imports
#
#  id             :bigint           not null, primary key
#  completed_at   :datetime
#  created_count  :integer          default(0)
#  error_messages :text
#  filename       :string
#  skipped_count  :integer          default(0)
#  status         :string           default("pending")
#  total_rows     :integer          default(0)
#  user_email     :string           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_imports_on_status      (status)
#  index_imports_on_user_email  (user_email)
#
require 'rails_helper'

RSpec.describe Import, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
