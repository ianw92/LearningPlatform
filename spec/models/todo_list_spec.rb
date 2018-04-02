require "rails_helper"
RSpec.describe TodoList, :type => :model do

  before do
    @todo_list = create(:todo_list)
  end

  it "is valid with valid attributes" do
    expect(@todo_list).to be_valid
  end

  it "is not valid without a title" do
    @todo_list.title = nil
    expect(@todo_list).to_not be_valid
  end

  it "is not valid without a user" do
    @todo_list.user = nil
    expect(@todo_list).to_not be_valid
  end

end
