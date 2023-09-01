module Rewardable
  extend ActiveSupport::Concern

  included do
    has_one :reward, dependent: :destroy, as: :rewardable

    accepts_nested_attributes_for :reward, reject_if: :all_blank
  end
end
