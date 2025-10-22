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
FactoryBot.define do
  factory :import do
    user_email { "MyString" }
    filename { "MyString" }
    total_rows { 1 }
    created_count { 1 }
    skipped_count { 1 }
    error_messages { "MyText" }
    status { "MyString" }
    completed_at { "2025-10-22 19:08:56" }
  end
end
