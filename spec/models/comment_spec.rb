require "rails_helper"
RSpec.describe Comment, :type => :model do

  before do
    @comment = build(:comment, user: nil)
    user = User.find_by(username: 'Test User')
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

  describe '#edited' do
    context "when comment has not been edited" do
      it "returns false" do
        expect(@comment.edited).to eq false
      end
    end

    context "when comment has been edited" do
      it "returns true" do
        @comment.updated_at = Date.today
        expect(@comment.edited).to eq true
      end
    end
  end

  describe "#time_since(updated_or_created)" do
    before do
      @datetime = "31 August 2018 00:00:00".to_datetime
      @comment.created_at = @datetime
      @comment.updated_at = @datetime
    end
    context "when 'created' supplied to method" do
      context "when comment created within last 60 seconds" do
        it "returns a string in the format 'no_of_seconds seconds ago'" do
          Timecop.freeze(@datetime + 3.seconds) do
            text = @comment.send(:time_since, 'created')
            expect(text).to eq "3 seconds ago"
          end
        end
      end

      context "when comment created within last 60 minutes" do
        it "returns a string in the format 'no_of_minutes minutes ago'" do
          Timecop.freeze(@datetime + 5.minutes) do
            text = @comment.send(:time_since, 'created')
            expect(text).to eq "5 minutes ago"
          end
        end
      end

      context "when comment created within last 24 hours" do
        it "returns a string in the format 'no_of_hours hours ago'" do
          Timecop.freeze(@datetime + 17.hours) do
            text = @comment.send(:time_since, 'created')
            expect(text).to eq "17 hours ago"
          end
        end
      end

      context "when comment created more than 24 hours ago" do
        it "returns a string in the format 'no_of_days days ago'" do
          Timecop.freeze(@datetime + 2.days) do
            text = @comment.send(:time_since, 'created')
            expect(text).to eq "2 days ago"
          end
        end
      end
    end

    context "when 'updated' supplied to method" do
      context "when comment updated within last 60 seconds" do
        it "returns a string in the format 'no_of_seconds seconds ago'" do
          Timecop.freeze(@datetime + 3.seconds) do
            text = @comment.send(:time_since, 'updated')
            expect(text).to eq "3 seconds ago"
          end
        end
      end

      context "when comment updated within last 60 minutes" do
        it "returns a string in the format 'no_of_minutes minutes ago'" do
          Timecop.freeze(@datetime + 5.minutes) do
            text = @comment.send(:time_since, 'updated')
            expect(text).to eq "5 minutes ago"
          end
        end
      end

      context "when comment updated within last 24 hours" do
        it "returns a string in the format 'no_of_hours hours ago'" do
          Timecop.freeze(@datetime + 17.hours) do
            text = @comment.send(:time_since, 'updated')
            expect(text).to eq "17 hours ago"
          end
        end
      end

      context "when comment updated more than 24 hours ago" do
        it "returns a string in the format 'no_of_days days ago'" do
          Timecop.freeze(@datetime + 2.days) do
            text = @comment.send(:time_since, 'updated')
            expect(text).to eq "2 days ago"
          end
        end
      end
    end
  end

  describe "#time_since_created" do
    it "should return whatever 'time_since(created)' returns" do
      allow(@comment).to receive(:time_since).with('created').and_return("5 seconds ago")
      text = @comment.time_since_created
      expect(text).to eq "5 seconds ago"
    end
  end

  describe "#time_since_updated" do
    it "should return whatever 'time_since(updated)' returns" do
      allow(@comment).to receive(:time_since).with('updated').and_return("5 seconds ago")
      text = @comment.time_since_updated
      expect(text).to eq "5 seconds ago"
    end
  end

end
