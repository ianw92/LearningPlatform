require "rails_helper"
RSpec.describe User, :type => :model do

  before do
    @user1 = create(:user)
  end

  it "is valid with valid attributes" do
    expect(@user1).to be_valid
  end

  it "has a unique username" do
    user2 = build(:user, email: "bob@gmail.com")
    expect(user2).to_not be_valid
  end

  it "has a unique email" do
    user2 = build(:user, username: "Bob")
    expect(user2).to_not be_valid
  end

  it "is not valid without a password" do
    user2 = build(:user, password: nil)
    expect(user2).to_not be_valid
  end

  it "is not valid without a username" do
    user2 = build(:user, username: nil)
    expect(user2).to_not be_valid
  end

  it "is not valid without an email" do
    user2 = build(:user, email: nil)
    expect(user2).to_not be_valid
  end

  it "is not valid until confirmed" do
    user2 = build(:user, confirmed_at: nil)
    expect(user2).to_not be_valid
  end

  it "is not valid with a password less than 6 characters" do
    user2 = build(:user, password: '12345', password_confirmation: '12345')
    expect(user2).to_not be_valid
  end

  it "is not valid if the password and password_confirmation do not match" do
    user2 = build(:user, password: 'aaaaaa', password_confirmation: 'bbbbbb')
    expect(user2).to_not be_valid
  end

  describe '#create_timer' do
    it "is triggered after user creation" do
      is_expected.to callback(:create_timer).after(:create)
    end

    it "creates a timer for the user that has just been created" do
      expect(Timer.find_by(user_id: @user1.id)).to be_present
    end
  end

  describe '#create_profile' do
    it "is triggered after user creation" do
      is_expected.to callback(:create_profile).after(:create)
    end

    it "creates a profile for the user that has just been created" do
      expect(Profile.find_by(user_id: @user1.id)).to be_present
    end
  end
end
