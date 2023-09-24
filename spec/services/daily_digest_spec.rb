require 'rails_helper'

RSpec.describe DailyDigestService do
  let(:users) { create_list(:user, 3) }

  it 'send daily digest to all users' do
    users.each { expect(DailyDigestMailer).to receive(:digest).and_call_original }
    subject.send_digest
  end
end
