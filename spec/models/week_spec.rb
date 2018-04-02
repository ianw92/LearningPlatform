require "rails_helper"
RSpec.describe Week, :type => :model do

  before do
    @week = create(:week)
  end

  it "is valid with valid attributes" do
    expect(@week).to be_valid
  end

  it "is not valid without a lecture_module_id" do
    @week.lecture_module_id = nil
    expect(@week).to_not be_valid
  end

  it "is not valid without a week_number" do
    @week.week_number = nil
    expect(@week).to_not be_valid
  end

  it "is not valid with a week_number not in 1..12" do
    @week.week_number = 0
    expect(@week).to_not be_valid
  end

  describe "#get_note_for(user)" do
    let(:user1) { User.find_by(username: 'test') }
    
    context "when no note exists for the week for the given user" do
      it "returns nil" do
        note = @week.get_note_for(user1)
        expect(note).to eq nil
      end
    end

    context "when a note does exist for the week for the given user" do
      it "returns the note" do
        note = create(:note, user: user1, week: @week)
        note = @week.get_note_for(user1)
        expect(note).to be_present
        expect(note.body).to eq "test note"
      end
    end
  end
end
