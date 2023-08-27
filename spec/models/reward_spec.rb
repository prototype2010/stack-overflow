require 'rails_helper'

RSpec.describe Reward, type: :model do
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to have_one(:user_reward) }
  it { is_expected.to belong_to(:rewardable) }
  it { is_expected.to belong_to(:rewardable) }

  it 'has one attached file' do
    expect(Reward.new.image).to be_an_instance_of(ActiveStorage::Attached::One)
  end
end
