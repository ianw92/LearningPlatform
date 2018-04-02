require "rails_helper"
RSpec.describe Note, :type => :model do

  before do
    @note = build(:note, user: nil)
    user = User.find_by(username: 'test')
    @note.user = user
    @note.save
  end

  it "is valid with valid attributes" do
    expect(@note).to be_valid
  end

  it "is not valid without a week" do
    @note.week = nil
    expect(@note).to_not be_valid
  end

  it "is not valid without a user" do
    @note.user = nil
    expect(@note).to_not be_valid
  end

  it "is not valid without a body" do
    @note.body = nil
    expect(@note).to_not be_valid
  end

  it "has a unique user/week pair" do
    week = Week.find(@note.week_id)
    user = User.find_by(username: 'test')
    note2 = build(:note, user: user, week: week)
    expect(note2).to_not be_valid
  end

  describe ".get_notes_for_module_and_user(lecture_module, user)" do
    let(:lecture_module) { LectureModule.find(@note.week.lecture_module.id) }
    let(:user1) { User.find_by(username: 'test') }
    context "when no notes exist for the given lecture_module and user" do
      it "returns nil" do
        Note.destroy_all
        notes = Note.get_notes_for_module_and_user(lecture_module, user1)
        expect(notes.count).to eq 0
      end
    end

    context "when notes do exist for the given lecture_module and user" do
      it "returns the notes" do
        notes = Note.get_notes_for_module_and_user(lecture_module, user1)
        expect(notes.count).to eq 1
        expect(notes[0].body).to eq "test note"
      end
    end
  end
end
