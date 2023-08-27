require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  let(:question) { create(:question, :with_link) }
  let(:link) { question.links.first }

  describe 'POST #delete' do
    before { login(question.author) }

    it 'returns http success' do
      expect { delete :delete, params: { id: link.id }, xhr: true }
        .to change(Link, :count).by(-1)
    end
  end
end
