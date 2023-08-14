require 'rails_helper'

RSpec.describe UserReward, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:reward) }
end
