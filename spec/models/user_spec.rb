require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#validations' do
    let(:user) { build(:user) }

    it "tests user object" do
      expect(user).to be_valid #article.valid? == true
    end

    it "has an valid email" do
      user.email = ' '
      expect(user).not_to be_valid
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "has an valid password" do
      user.password = ' '
      expect(user).not_to be_valid
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "has empty association with contacts" do
      expect(user).to be_valid
      expect(user.contacts).to eq([])
    end

    it "validates he uniqueness of email" do
      user1 = create(:user)
      expect(user1).to be_valid
      user2 = build(:user, email: user1.email)
      expect(user2).not_to be_valid
      expect(user2.errors[:email]).to include("has already been taken")
    end
  end
end
