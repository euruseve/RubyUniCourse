# frozen_string_literal: true

# == Schema Information
#
# Table name: admins
#
#  id                     :bigint           not null, primary key
#  avatar_data            :jsonb
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_admins_on_email                 (email) UNIQUE
#  index_admins_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :admin do
  end
end
