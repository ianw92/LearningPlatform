require "rails_helper"
RSpec.describe Timer, :type => :model do

  before do
    @timer = create(:timer)
  end

  it "is valid with valid attributes" do
    expect(@timer).to be_valid
  end

  it "is not valid if study_length is less than 1" do
    @timer.study_length = 0
    expect(@timer).to_not be_valid
  end

  it "is not valid if study_length is not an integer" do
    @timer.study_length = 3.5
    expect(@timer).to_not be_valid
  end

  it "is not valid if short_break_length is less than 1" do
    @timer.short_break_length = 0
    expect(@timer).to_not be_valid
  end

  it "is not valid if short_break_length is not an integer" do
    @timer.short_break_length = 3.5
    expect(@timer).to_not be_valid
  end

  it "is not valid if long_break_length is less than 1" do
    @timer.long_break_length = 0
    expect(@timer).to_not be_valid
  end

  it "is not valid if long_break_length is not an integer" do
    @timer.long_break_length = 3.5
    expect(@timer).to_not be_valid
  end

end
