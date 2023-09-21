require 'rails_helper'

RSpec.describe Subscription, type: :model do
  it { is_expected.to belong_to(:subscriptionable) }
  it { is_expected.to belong_to(:user) }
end
