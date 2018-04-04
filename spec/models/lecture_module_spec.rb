require "rails_helper"
RSpec.describe LectureModule, :type => :model do

  before do
    @lecture_module = create(:lecture_module)
  end

  it "is valid with valid attributes" do
    expect(@lecture_module).to be_valid
  end

  it "is not valid without a code" do
    @lecture_module.code = nil
    expect(@lecture_module).to_not be_valid
  end

  it "is not valid without an academic_year_end" do
    @lecture_module.academic_year_end = nil
    expect(@lecture_module).to_not be_valid
  end

  it "is not valid without a semester" do
    @lecture_module.semester = nil
    expect(@lecture_module).to_not be_valid
  end

  it "is not valid without a name" do
    @lecture_module.name = nil
    expect(@lecture_module).to_not be_valid
  end

  it "is not valid with a code of less than 5 characters" do
    @lecture_module.code = '1234'
    expect(@lecture_module).to_not be_valid
  end

  it "is not valid with a code of more than 20 characters" do
    @lecture_module.code = 'twenty-one characters'
    expect(@lecture_module).to_not be_valid
  end

  it "is not valid with an academic_year_end of greater than 5 years ago" do
    @lecture_module.academic_year_end = Date.today.year - 6
    expect(@lecture_module).to_not be_valid
  end

  it "is not valid with an academic_year_end of greater than 1 year in the future" do
    @lecture_module.academic_year_end = Date.today.year + 2
    expect(@lecture_module).to_not be_valid
  end

  it "is not valid with a semester not in [0,1,2]" do
    @lecture_module.semester = -1
    expect(@lecture_module).to_not be_valid
  end

  it "is not valid with a name of less than 5 characters" do
    @lecture_module.name = '1234'
    expect(@lecture_module).to_not be_valid
  end

  it "is not valid with a name of more than 50 characters" do
    @lecture_module.name = 'this string is fifty-one characters long so fails!!'
    expect(@lecture_module).to_not be_valid
  end

  it "has a unique code/academic_year_end pair" do
    user1 = User.find_by(username: 'test')
    lecture_module2 = build(:lecture_module, user: user1)
    expect(lecture_module2).to_not be_valid
  end

  describe '#create_user_module_linker' do
    it "is triggered after lecture_module creation" do
      is_expected.to callback(:create_user_module_linker).after(:create)
    end

    it "creates a user_module_linker between the lecture_module and it's owner" do
      expect(UserModuleLinker.find_by(lecture_module: @lecture_module, user_id: @lecture_module.user_id)).to be_present
    end
  end

  describe '#create_weeks_for_module' do
    it "is triggered after lecture_module creation" do
      is_expected.to callback(:create_weeks_for_module).after(:create)
    end

    it "creates 12 weeks for the module that has just been created" do
      expect(Week.where(lecture_module: @lecture_module).count).to eq 12
    end
  end

  describe '#delete_assosciated_user_module_linkers' do
    it "is triggered around lecture_module deletion" do
      is_expected.to callback(:delete_assosciated_user_module_linkers).around(:destroy)
    end

    it "destroys all associated user_module_linkers" do
      lecture_module_id = @lecture_module.id
      @lecture_module.destroy
      expect(UserModuleLinker.find_by(lecture_module_id: lecture_module_id, user_id: @lecture_module.user_id)).to_not be_present
    end
  end

  describe "#semester=(val)" do
    context "when val is 'Spring'" do
      it "inputs '2' as the semester attribute for the lecture_module" do
        @lecture_module.semester = 1
        @lecture_module.update(semester: 'Spring')
        expect(@lecture_module.semester).to eq 2
      end
    end

    context "when val is 'Autumn'" do
      it "inputs '1' as the semester attribute for the lecture_module" do
        @lecture_module.update(semester: 'Autumn')
        expect(@lecture_module.semester).to eq 1
      end
    end

    context "when val is 'Academic Year'" do
      it "inputs '0' as the semester attribute for the lecture_module" do
        @lecture_module.update(semester: 'Academic Year')
        expect(@lecture_module.semester).to eq 0
      end
    end
  end

  describe ".process_semester(semester_as_text)" do
    context "when semester_as_text is 'Academic Year'" do
      it "returns 0" do
        text = LectureModule.process_semester('Academic Year')
        expect(text).to eq 0
      end
    end

    context "when semester_as_text is 'Autumn'" do
      it "returns 1" do
        text = LectureModule.process_semester('Autumn')
        expect(text).to eq 1
      end
    end

    context "when semester_as_text is 'Spring'" do
      it "returns 2" do
        text = LectureModule.process_semester('Spring')
        expect(text).to eq 2
      end
    end
  end

  describe ".set_current_year_and_semester" do
    context "when date is between 1st September and January 31st (inclusive)" do
      let(:date) { "1 September 2017".to_datetime }
      it "will set current_year_end to the next numerical year" do
        Timecop.freeze(date) do
          current_year_end, current_semester = LectureModule.set_current_year_and_semester
          expect(current_year_end).to eq (date.year + 1)
        end
      end

      it "will set current_semester to 1" do
        Timecop.freeze(date) do
          current_year_end, current_semester = LectureModule.set_current_year_and_semester
          expect(current_semester).to eq 1
        end
      end
    end

    context "when date is between 1st February and 31st August (inclusive)" do
      let(:date) { "31 August 2018".to_datetime }
      it "will set @current_year_end to the current numerical year" do
        Timecop.freeze(date) do
          current_year_end, current_semester = LectureModule.set_current_year_and_semester
          expect(current_year_end).to eq (date.year)
        end
      end

      it "will set @current_semester to 2" do
        Timecop.freeze(date) do
          current_year_end, current_semester = LectureModule.set_current_year_and_semester
          expect(current_semester).to eq 2
        end
      end
    end
  end

  describe "#get_module_full_title" do
    it "returns the full title string of a module" do
      text = @lecture_module.get_module_full_title
      expect(text).to eq "TEST123 - Test Module - SPRING 2017/2018"
    end
  end

  describe "#semester_as_string" do
    context "when semester is 0" do
      it "returns 'ACADEMIC YEAR'" do
        @lecture_module.update(semester: 'Academic Year')
        expect(@lecture_module.semester).to eq 0
        text = @lecture_module.semester_as_string
        expect(text).to eq "ACADEMIC YEAR"
      end
    end

    context "when semester is 1" do
      it "returns 'AUTUMN'" do
        @lecture_module.update(semester: 'Autumn')
        expect(@lecture_module.semester).to eq 1
        text = @lecture_module.semester_as_string
        expect(text).to eq "AUTUMN"
      end
    end

    context "when semester is 2" do
      it "returns 'SPRING'" do
        text = @lecture_module.semester_as_string
        expect(text).to eq "SPRING"
      end
    end
  end

  describe "#academic_year_string" do
    it "returns the string representing the academic year (e.g.2017/2018)" do
      text = @lecture_module.academic_year_string
      expect(text).to eq "2017/2018"
    end
  end

  describe "getting current/completed modules methods" do
    before do
      @user1 = User.find_by(username: 'test')
      @user2 = create(:user, email: 'test2@example.com', username: 'test2')
      @lecture_module2 = create(:lecture_module, user: @user1, code: 'TEST222', academic_year_end: 2017, name: "Test Module 2")
      @lecture_module3 = create(:lecture_module, user: @user2, code: 'TEST333', academic_year_end: 2018, name: "Test Module 3")
      @lecture_module4 = create(:lecture_module, user: @user2, code: 'TEST444', academic_year_end: 2017, name: "Test Module 4")
    end

    describe ".get_my_current_modules(user)" do
      it "returns all current modules that the user is linked with" do
        date = "1 March 2018".to_datetime
        Timecop.freeze(date) do
          my_current_modules = LectureModule.get_my_current_modules(@user1)
          expect(my_current_modules.count).to eq 1
          expect(my_current_modules[0].name).to eq "Test Module"
        end
      end
    end

    describe ".get_my_completed_modules(user)" do
      it "returns all completed modules that the user is linked with" do
        date = "1 March 2018".to_datetime
        Timecop.freeze(date) do
          my_completed_modules = LectureModule.get_my_completed_modules(@user1)
          expect(my_completed_modules.count).to eq 1
          expect(my_completed_modules[0].name).to eq "Test Module 2"
        end
        Timecop.return

        date = "1 September 2018".to_datetime
        Timecop.freeze(date) do
          my_completed_modules = LectureModule.get_my_completed_modules(@user1)
          expect(my_completed_modules.count).to eq 2
          expect(my_completed_modules[0].name).to eq "Test Module"
          expect(my_completed_modules[1].name).to eq "Test Module 2"
        end
      end
    end

    describe ".get_other_current_modules(user)" do
      it "returns all current modules that the user is NOT linked with" do
        date = "1 March 2018".to_datetime
        Timecop.freeze(date) do
          other_current_modules = LectureModule.get_other_current_modules(@user1)
          expect(other_current_modules.count).to eq 1
          expect(other_current_modules[0].name).to eq "Test Module 3"
        end
      end
    end

    describe ".get_other_completed_modules(user)" do
      it "returns all completed modules that the user is NOT linked with" do
        date = "1 March 2018".to_datetime
        Timecop.freeze(date) do
          other_completed_modules = LectureModule.get_other_completed_modules(@user1)
          expect(other_completed_modules.count).to eq 1
          expect(other_completed_modules[0].name).to eq "Test Module 4"
        end

        date = "1 September 2018".to_datetime
        Timecop.freeze(date) do
          other_completed_modules = LectureModule.get_other_completed_modules(@user1)
          expect(other_completed_modules.count).to eq 2
          expect(other_completed_modules[0].name).to eq "Test Module 3"
          expect(other_completed_modules[1].name).to eq "Test Module 4"
        end
      end
    end
  end

end
