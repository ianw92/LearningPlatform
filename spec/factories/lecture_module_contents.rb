FactoryBot.define do

  factory :lecture_module_content do
    week
    content_file_name 'test.pdf'
    content_content_type 'application/pdf'
    content_file_size 10000000
    content_updated_at Date.today
  end

end
