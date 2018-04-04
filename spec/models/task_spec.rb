require "rails_helper"
RSpec.describe Task, :type => :model do

  before do
    @task = create(:task)
  end

  it "is valid with valid attributes" do
    expect(@task).to be_valid
  end

  it "is not valid without a todo_list" do
    @task.todo_list = nil
    expect(@task).to_not be_valid
  end

  it "is not valid without a title" do
    @task.title = nil
    expect(@task).to_not be_valid
  end

  it "is not valid without a due_date" do
    @task.due_date = nil
    expect(@task).to_not be_valid
  end

  it "is not valid without completed" do
    @task.completed = nil
    expect(@task).to_not be_valid
  end

  describe ".get_tasks_for_lists(todo_lists)" do
    context "when tasks exist for the given todo_lists" do
      it "returns all tasks for the given todo_lists" do
        todo_lists = TodoList.all
        tasks = Task.get_tasks_for_lists(todo_lists)
        expect(tasks.count).to eq 1
        expect(tasks[0].title).to eq 'Test Task'
      end
    end

    context "when no tasks exist for the given todo_lists" do
      it "returns an empty list" do
        Task.destroy_all
        todo_lists = TodoList.all
        tasks = Task.get_tasks_for_lists(todo_lists)
        expect(tasks.count).to eq 0
      end
    end
  end

  describe ".get_tasks_for_list" do
    it "returns a list of all tasks that belong to the supplied todo_list" do
      todo_list = TodoList.find_by(title: "Todo List Test")
      task2 = Task.create(todo_list: todo_list, title: "Test Task 2", due_date: Date.new, completed:false)
      tasks = Task.get_tasks_for_list(todo_list)
      expect(tasks.size).to eq 2
    end
  end

  describe ".change_completed_status" do
    context "when completed is false" do
      it "changes completed to true" do
        Task.change_completed_status(@task)
        task = Task.find(@task.id)
        expect(task.completed).to eq true
      end
    end

    context "when completed is true" do
      it "changes completed to false" do
        @task.completed = true
        Task.change_completed_status(@task)
        task = Task.find(@task.id)
        expect(task.completed).to eq false
      end
    end
  end

  describe ".sort_tasks(tasks, sort_style)" do
    context "when sort_style is 'due_date'" do
      it "returns the list of tasks sorted by due_date" do
        todo_list = TodoList.find_by(title: 'Todo List Test')
        task2 = create(:task, todo_list: todo_list, due_date: Date.today - 1.days, title: "Test Task 2")
        tasks = Task.sort_tasks(Task.all, 'due_date')
        expect(tasks.count).to eq 2
        expect(tasks[0].title).to eq 'Test Task 2'
        expect(tasks[1].title).to eq 'Test Task'
      end
    end

    context "when sort_style is 'title'" do
      it "returns the list of tasks sorted by title" do
        todo_list = TodoList.find_by(title: 'Todo List Test')
        task2 = create(:task, todo_list: todo_list, title: "aaa")
        tasks = Task.sort_tasks(Task.all, 'title')
        expect(tasks.count).to eq 2
        expect(tasks[0].title).to eq 'aaa'
        expect(tasks[1].title).to eq 'Test Task'
      end
    end

    context "when sort_style is 'position'" do
      it "returns the list of tasks sorted according to the position field" do
        @task.update_attribute(:position, 2)
        todo_list = TodoList.find_by(title: 'Todo List Test')
        task2 = create(:task, todo_list: todo_list, position: 1, title: "Test Task 2")
        tasks = Task.sort_tasks(Task.all, 'position')
        expect(tasks.count).to eq 2
        expect(tasks[0].title).to eq 'Test Task 2'
        expect(tasks[1].title).to eq 'Test Task'
      end
    end
  end

  describe "#get_due_status" do
    context "when completed is true" do
      context "when corresponding users show_completed_tasks is true" do
        it "returns '_completed task_show'" do
          @task.completed = true
          @task.todo_list.user.profile.show_completed_tasks = true
          text = @task.get_due_status
          expect(text).to eq "_completed task_show"
        end
      end

      context "when corresponding users show_completed_tasks is false" do
        it "returns '_completed'" do
          @task.completed = true
          text = @task.get_due_status
          expect(text).to eq "_completed"
        end
      end
    end

    context "when completed is false" do
      context "when due_date is before the current day" do
        it "returns '_overdue'" do
          @task.due_date -= 1.day
          text = @task.get_due_status
          expect(text).to eq "_overdue"
        end
      end

      context "when due_date is the current day" do
        it "returns '_due_today'" do
          text = @task.get_due_status
          expect(text).to eq "_due_today"
        end
      end

      context "when due_date is tomorrow" do
        it "returns '_due_tomorrow'" do
          @task.due_date += 1.day
          text = @task.get_due_status
          expect(text).to eq "_due_tomorrow"
        end
      end

      context "when due_date is after tomorrow" do
        it "returns nil" do
          @task.due_date += 2.days
          text = @task.get_due_status
          expect(text).to eq nil
        end
      end
    end
  end

end
