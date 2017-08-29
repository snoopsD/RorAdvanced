require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:questions) }
  it { should have_many(:answers) }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe 'owner' do
    let(:user)     { create(:user) }

    it 'true if user is author' do
      question = create(:question, user: user)
      expect(user).to be_owner(question)
    end

    it 'false if user is not author' do
      question = create(:question, user: create(:user))
      expect(user).to_not be_owner(question)
    end
  end
end
