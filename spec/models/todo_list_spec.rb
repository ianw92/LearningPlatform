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

  describe ".get_todo_lists_for_user(user)" do
    context "when the given user has todo_lists" do
      it "returns all todo_lists belonging to the given user" do
        user = User.find_by(username: 'Test User')
        todo_lists = TodoList.get_todo_lists_for_user(user)
        expect(todo_lists.count).to eq 1
        expect(todo_lists[0].title).to eq 'Todo List Test'
      end
    end

    context "when the given user has no todo_lists" do
      it "returns an empty list" do
        TodoList.destroy_all
        user = User.find_by(username: 'Test User')
        todo_lists = TodoList.get_todo_lists_for_user(user)
        expect(todo_lists.count).to eq 0
      end
    end
  end

end
