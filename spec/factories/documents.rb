FactoryGirl.define do
  factory :document do
    subject_id 1
    user_id 1
    class_year 93
    document_type 1
    number 1
    page 1
    with_answer false
    note "dummy file"
    download_count 1
    file_name "dummy.pdf"
    file_mime "application/pdf"
    file_sha1 "89e11348d56317c282e76feb3374aeb4db09717c"
  end
end
