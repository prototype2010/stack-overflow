require 'rails_helper'

RSpec.describe AnswerNotificationJob, type: :job do
  let(:service) { double('AnswerNotificationService') }

  before do
    allow(AnswerNotificationService).to receive(:new).and_return(service)
  end

  it 'calls DailyDigestService and returns service' do
    expect(service).to receive(:notify)
    AnswerNotificationJob.perform_now(create(:question))
  end
end
