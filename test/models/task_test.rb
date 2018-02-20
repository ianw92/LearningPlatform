require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  setup do
    @task = tasks(:one)
  end

  test "title and due_date must not be empty" do
    task = tasks(:empty_test)
    assert task.invalid?
    assert task.errors[:title].any?
    assert task.errors[:due_date].any?
  end

  test "todo_list must exist" do
    @task.todo_list_id = 999
    assert @task.invalid?
    assert @task.errors[:todo_list].any?
  end
end
