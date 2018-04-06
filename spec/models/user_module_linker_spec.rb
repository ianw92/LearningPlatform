require "rails_helper"
RSpec.describe UserModuleLinker, :type => :model do

  before do
    @user_module_linker = build(:user_module_linker, user: nil)
    # Delete the linker that was autocreated when the lecture_module was created
    UserModuleLinker.destroy_all
    user = User.find_by(username: 'Test User')
    @user_module_linker.user = user
    @user_module_linker.save
  end

  it "is valid with valid attributes" do
    expect(@user_module_linker).to be_valid
  end

  it "is not valid without a lecture_module_id" do
    @user_module_linker.lecture_module_id = nil
    expect(@user_module_linker).to_not be_valid
  end

  it "is not valid without a user_id" do
    @user_module_linker.user_id = nil
    expect(@user_module_linker).to_not be_valid
  end

  it "has a unique user/lecture_module pair" do
    lecture_module = LectureModule.find_by(name: 'Test Module')
    user = User.find_by(username: 'test')
    user_module_linker2 = build(:user_module_linker, user: user, lecture_module: lecture_module)
    expect(user_module_linker2).to_not be_valid
  end

  describe "add/remove methods" do
    let(:lecture_module) { LectureModule.find_by(name: 'Test Module') }
    let(:user) { User.find_by(username: 'Test User') }
    describe ".add_new_linker(lecture_module, user)" do
      it "adds a new user_module_linker record for the given lecture_module and user" do
        UserModuleLinker.destroy_all
        expect(UserModuleLinker.all.count).to eq 0

        linker = UserModuleLinker.add_new_linker(lecture_module, user)
        linker.save
        expect(UserModuleLinker.all.count).to eq 1
      end
    end

    describe ".remove_linker(lecture_module, user)" do
      it "deletes the user_module_linker for the given lecture_module and user" do
        UserModuleLinker.remove_linker(lecture_module, user)
        expect(UserModuleLinker.all.count).to eq 0
      end
    end
  end

end
