require "rails_helper"
RSpec.describe Comment, :type => :model do

  before do
    @comment = build(:comment, user: nil)
    user = User.find_by(username: 'test')
    @comment.user = user
    @comment.save
  end

  it "is valid with valid attributes" do
    expect(@comment).to be_valid
  end

  it "is not valid without a week" do
    @comment.week = nil
    expect(@comment).to_not be_valid
  end

  it "is not valid without a user" do
    @comment.user = nil
    expect(@comment).to_not be_valid
  end

  it "is not valid without a body" do
    @comment.body = nil
    expect(@comment).to_not be_valid
  end

  describe "#time_since_updated" do
    context "when comment updated within last 60 seconds" do
      it "returns a string in the format 'no_of_seconds seconds ago'" do
        datetime = "31 August 2018 00:00:00".to_datetime
        @comment.updated_at = datetime
        Timecop.freeze(datetime + 3.seconds) do
          text = @comment.time_since_updated
          expect(text).to eq "3 seconds ago"
        end
      end
    end

    context "when comment updated within last 60 minutes" do
      it "returns a string in the format 'no_of_minutes minutes ago'" do
        datetime = "31 August 2018 00:00:00".to_datetime
        @comment.updated_at = datetime
        Timecop.freeze(datetime + 5.minutes) do
          text = @comment.time_since_updated
          expect(text).to eq "5 minutes ago"
        end
      end
    end

    context "when comment updated within last 24 hours" do
      it "returns a string in the format 'no_of_hours hours ago'" do
        datetime = "31 August 2018 00:00:00".to_datetime
        @comment.updated_at = datetime
        Timecop.freeze(datetime + 17.hours) do
          text = @comment.time_since_updated
          expect(text).to eq "17 hours ago"
        end
      end
    end

    context "when comment updated more than 24 hours ago" do
      it "returns a string in the format 'no_of_days days ago'" do
        datetime = "31 August 2018 00:00:00".to_datetime
        @comment.updated_at = datetime
        Timecop.freeze(datetime + 2.days) do
          text = @comment.time_since_updated
          expect(text).to eq "2 days ago"
        end
      end
    end
  end

end
