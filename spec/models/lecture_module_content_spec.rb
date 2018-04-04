require "rails_helper"
RSpec.describe LectureModuleContent, :type => :model do

  before do
    @lecture_module_content = create(:lecture_module_content)
  end

  it "is valid with valid attributes" do
    expect(@lecture_module_content).to be_valid
  end

  it "is not valid without a week_id" do
    @lecture_module_content.week_id = nil
    expect(@lecture_module_content).to_not be_valid
  end

  it "is not valid without either content(pdf) or youTube_link" do
    @lecture_module_content.content = nil
    expect(@lecture_module_content).to_not be_valid
  end

  it "is not valid with content_type not being 'pdf'" do
    @lecture_module_content.content_content_type = 'image/jpeg'
    expect(@lecture_module_content).to_not be_valid
  end

  it "is not valid with youTube_link of invalid format" do
    @lecture_module_content.content = nil
    @lecture_module_content.youTube_link = 'invalid string'
    expect(@lecture_module_content).to_not be_valid
  end

  describe "#content_xor_youtube_must_exist" do
    context "when neither content or youTube_link exist" do
      it "adds a new error stating one of the two must exist" do
        @lecture_module_content.content = nil
        @lecture_module_content.content_xor_youtube_must_exist
        expect(@lecture_module_content.errors[:base]).
          to include("Lecture Module Content must have either a pdf file or a youTube link")
      end
    end

    context "when content and youTube_link exist" do
      it "adds a new error stating both cannot exist" do
        @lecture_module_content.youTube_link = 'https://www.youtube.com/embed/test'
        @lecture_module_content.content_xor_youtube_must_exist
        expect(@lecture_module_content.errors[:base]).
          to include("Lecture Module Content cannot have both a pdf file and a youTube link")
      end
    end

    context "when content exists and youTube_link does not exist" do
      it "returns nil" do
        return_val = @lecture_module_content.content_xor_youtube_must_exist
        expect(return_val).to eq nil
      end
    end

    context "when youTube_link exists and content does not exist" do
      it "returns nil" do
        @lecture_module_content.content = nil
        @lecture_module_content.youTube_link = 'https://www.youtube.com/embed/test'
        return_val = @lecture_module_content.content_xor_youtube_must_exist
        expect(return_val).to eq nil
      end
    end
  end

  describe "#get_module_full_title" do
    it "returns the full title of the associated lecture_module" do
      title = @lecture_module_content.get_module_full_title
      expect(title).to eq "TEST123 - Test Module - SPRING 2017/2018"
    end
  end

  describe "#week_number" do
    it "returns the week_number of the associated week" do
      week_num = @lecture_module_content.week_number
      expect(week_num).to eq 1
    end
  end

  describe "#lecture_module_id" do
    it "returns the lecture_module_id of the associated lecture_module" do
      lecture_module = LectureModule.find_by(name: 'Test Module')
      lecture_module_id = @lecture_module_content.lecture_module_id
      expect(lecture_module_id).to eq lecture_module.id
    end
  end

  describe "#title" do
    context "when description exists" do
      context "when content exists" do
        it "returns the title in format 'description | content_file_name'" do
          @lecture_module_content.description = 'test'
          title = @lecture_module_content.title
          expect(title).to eq "test | test.pdf"
        end
      end

      context "when youTube_link exists" do
        it "returns the title in format 'description | youTube_link'" do
          @lecture_module_content.content = nil
          @lecture_module_content.description = 'test'
          @lecture_module_content.youTube_link = 'https://www.youtube.com/embed/test'
          title = @lecture_module_content.title
          expect(title).to eq "test | https://www.youtube.com/embed/test"
        end
      end
    end

    context "when description is nil" do
      context "when content exists" do
        it "returns the title in format 'content_file_name'" do
          title = @lecture_module_content.title
          expect(title).to eq "test.pdf"
        end
      end

      context "when youTube_link exists" do
        it "returns the title in format 'youTube_link'" do
          @lecture_module_content.content = nil
          @lecture_module_content.youTube_link = 'https://www.youtube.com/embed/test'
          title = @lecture_module_content.title
          expect(title).to eq "https://www.youtube.com/embed/test"
        end
      end
    end
  end

  describe "#s3_url" do
    context "when content exists" do
      it "returns the modified content url to include the AWS region" do
        @lecture_module_content.content.stub(:url) { "//s3.amazonaws.com/learning-platform-bucket...test.pdf" }
        url = @lecture_module_content.s3_url
        expect(url).to eq "//s3.eu-west-2.amazonaws.com/learning-platform-bucket...test.pdf"
      end
    end

    context "when content does not exist" do
      it "returns nil" do
        @lecture_module_content.content = nil
        url = @lecture_module_content.s3_url
        expect(url).to eq nil
      end
    end
  end


end
