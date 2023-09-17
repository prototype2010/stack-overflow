require 'rails_helper'

RSpec.describe Question, type: :model do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to have_many(:answers) }
  it { is_expected.to have_many(:links) }
  it { is_expected.to accept_nested_attributes_for(:links) }
  it { is_expected.to have_db_index(:title) }

  it 'has one attached file' do
    expect(Question.new.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end

  describe 'reputation' do
    let(:question) { build(:question) }

    it 'calls ReputationJob' do
      expect(ReputationJob).to receive(:perform_later).with(question)
      question.save!
    end
  end
end
