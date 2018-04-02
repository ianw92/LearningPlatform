require "rails_helper"
RSpec.describe Profile, :type => :model do

  before do
    @profile = create(:profile)
  end

  it "is valid with valid attributes" do
    expect(@profile).to be_valid
  end

  it "is not valid without 'sort_tasks_by' attribute" do
    @profile.sort_tasks_by = nil
    expect(@profile).to_not be_valid
  end

  it "is not valid without 'show_completed_tasks' attribute" do
    @profile.show_completed_tasks = nil
    expect(@profile).to_not be_valid
  end

  it "is not valid without 'show_notes' attribute" do
    @profile.show_notes = nil
    expect(@profile).to_not be_valid
  end

  it "is not valid without 'show_comments' attribute" do
    @profile.show_comments = nil
    expect(@profile).to_not be_valid
  end

  describe "#change_sort_parameter" do
    context "when new_param supplied is 'title'" do
      it "changes the sort_parameter to 'title'" do
        @profile = Profile.change_sort_parameter(@profile, 'title')
        expect(@profile.sort_tasks_by).to eq 'title'
      end
    end

    context "when new_param supplied is 'position'" do
      it "changes the sort_parameter to 'position'" do
        @profile = Profile.change_sort_parameter(@profile, 'position')
        expect(@profile.sort_tasks_by).to eq 'position'
      end
    end

    context "when new_param supplied is 'due_date'" do
      it "changes the sort_parameter to 'due_date'" do
        @profile.sort_tasks_by = 1
        @profile = Profile.change_sort_parameter(@profile, 'due_date')
        expect(@profile.sort_tasks_by).to eq 'due_date'
      end
    end
  end

  describe "#change_show_completed_state" do
    context "when show_completed_tasks is false" do
      it "changes show_completed_tasks to true" do
        @profile = @profile.change_show_completed_state
        expect(@profile.show_completed_tasks).to eq true
      end
    end

    context "when show_completed_tasks is true" do
      it "changes show_completed_tasks to true" do
        @profile.show_completed_tasks = true
        @profile = @profile.change_show_completed_state
        expect(@profile.show_completed_tasks).to eq false
      end
    end
  end

  describe "#change_show_notes_state" do
    context "when show_notes is false" do
      it "changes show_notes to true" do
        @profile = @profile.change_show_notes_state
        expect(@profile.show_notes).to eq true
      end
    end

    context "when show_notes is true" do
      it "changes show_notes to false" do
        @profile.show_notes = true
        @profile = @profile.change_show_notes_state
        expect(@profile.show_notes).to eq false
      end
    end
  end

  describe "#change_show_comments_state" do
    context "when show_comments is false" do
      it "changes show_comments to true" do
        @profile = @profile.change_show_comments_state
        expect(@profile.show_comments).to eq true
      end
    end

    context "when show_comments is true" do
      it "changes show_comments to false" do
        @profile.show_comments = true
        @profile = @profile.change_show_comments_state
        expect(@profile.show_comments).to eq false
      end
    end
  end

  describe "#show_or_hide_button_text" do
    context "when the type supplied is 'tasks'" do
      context "when show_completed_tasks is false" do
        it "returns 'Show Completed'" do
          text = @profile.show_or_hide_button_text('tasks')
          expect(text).to eq 'Show Completed'
        end
      end

      context "when show_completed_tasks is true" do
        it "returns 'Hide Completed'" do
          @profile.show_completed_tasks = true
          text = @profile.show_or_hide_button_text('tasks')
          expect(text).to eq 'Hide Completed'
        end
      end
    end

    context "when the type supplied is 'notes'" do
      context "when show_notes is false" do
        it "returns 'Show Notes'" do
          text = @profile.show_or_hide_button_text('notes')
          expect(text).to eq 'Show Notes'
        end
      end

      context "when show_notes is true" do
        it "returns 'Hide Notes'" do
          @profile.show_notes = true
          text = @profile.show_or_hide_button_text('notes')
          expect(text).to eq 'Hide Notes'
        end
      end
    end

    context "when the type supplied is 'comments'" do
      context "when show_comments is false" do
        it "returns 'Show Discussion'" do
          text = @profile.show_or_hide_button_text('comments')
          expect(text).to eq 'Show Discussion'
        end
      end

      context "when show_comments is true" do
        it "returns 'Hide Discussion'" do
          @profile.show_comments = true
          text = @profile.show_or_hide_button_text('comments')
          expect(text).to eq 'Hide Discussion'
        end
      end
    end
  end

  describe "#get_show_notes_status" do
    context "when show_notes is false" do
      it "returns 'notes_hidden'" do
        text = @profile.get_show_notes_status
        expect(text).to eq 'notes_hidden'
      end
    end

    context "when show_notes is true" do
      it "returns nil" do
        @profile.show_notes = true
        text = @profile.get_show_notes_status
        expect(text).to eq nil
      end
    end
  end

  describe "#get_show_comments_status" do
    context "when show_comments is false" do
      it "returns 'comments_hidden'" do
        text = @profile.get_show_comments_status
        expect(text).to eq 'comments_hidden'
      end
    end

    context "when show_comments is true" do
      it "returns nil" do
        @profile.show_comments = true
        text = @profile.get_show_comments_status
        expect(text).to eq nil
      end
    end
  end

end
