unless cy = ClassYear.find_by(year: 93)
  cy = ClassYear.create!(year: 93)
end

unless admin = User.find_by(email: "admin@eis.hokudai.ac.jp")
  admin = User.create(
    email:         "admin@eis.hokudai.ac.jp",
    password:      "admin",
    family_name:   "admin",
    given_name:    "admin",
    handle_name:   "admin",
    birthday:      "1990-01-01",
    email_mobile:  "admin@example.com",
    class_year_id: cy.id,
    admin:         true
  )
end
admin.activate!
admin.approve!

unless guest = User.find_by(email: "guest@eis.hokudai.ac.jp")
  guest = User.create(
    email:         "guest@eis.hokudai.ac.jp",
    password:      "guest",
    family_name:   "guest",
    given_name:    "guest",
    handle_name:   "guest",
    birthday:      "1990-01-01",
    email_mobile:  "guest@example.com",
    class_year_id: cy.id,
    admin:         false
  )
end
guest.activate!
guest.approve!

AccessToken.skip_callback(:validation, :before, :generate_token)
AccessToken.create(
  user:  admin,
  token: "4ebbcf209ca3625dfe0b2595d627ffacd90f8cefd69722712a451a7c291643af"
)
AccessToken.create(
  user:  guest,
  token: "1936be4f6d3da5ea51676736dfde47cf25476fdcb34fcb01e4d8cbbf20818fba"
)
AccessToken.set_callback(:validation, :before, :generate_token)

unless not_activated = User.find_by(email: "not_activated@eis.hokudai.ac.jp")
  not_activated = User.create(
    email:         "not_activated@eis.hokudai.ac.jp",
    password:      "not_activated",
    family_name:   "not_activated",
    given_name:    "not_activated",
    handle_name:   "not_activated",
    birthday:      "1990-01-01",
    email_mobile:  "not_activated@example.com",
    class_year_id: cy.id,
    admin:         false
  )
end
not_activated.activation_token = "d1nbuwA8vmVKRJR9xzrn"
not_activated.save!

sub1 = Subject.create!(title_ja: "生化学", title_en: "biochemistry")
sub2 = Subject.create!(title_ja: "解剖学", title_en: "anatomy")
sub3 = Subject.create!(title_ja: "生理学", title_en: "physiology")
sub4 = Subject.create!(title_ja: "薬理学", title_en: "pharmacology")

sem1 = Semester.create!(class_year_id: 1, identifier: "2a")
sem2 = Semester.create!(class_year_id: 1, identifier: "2b")

sem1.subjects << sub1
sem1.subjects << sub2
sem2.subjects << sub3
sem2.subjects << sub4

sub1.documents << Document.create(subject: sub1, class_year: 93, code:    1)
sub1.documents << Document.create(subject: sub1, class_year: 93, code:    2)
sub1.documents << Document.create(subject: sub1, class_year: 93, code:   99)
sub1.documents << Document.create(subject: sub1, class_year: 93, code: 1099)
sub1.documents << Document.create(subject: sub1, class_year: 93, code: 2002)
sub1.documents << Document.create(subject: sub1, class_year: 93, code: 2004)
sub1.documents << Document.create(subject: sub1, class_year: 93, code: 2009)
sub1.documents << Document.create(subject: sub1, class_year: 93, code: 3001)
sub1.documents << Document.create(subject: sub1, class_year: 93, code: 3003)
sub1.documents << Document.create(subject: sub1, class_year: 93, code: 3004)
sub1.documents << Document.create(subject: sub1, class_year: 93, code: 4001)
sub1.documents << Document.create(subject: sub1, class_year: 93, code: 5000)

Document.all.each do |doc|
  doc.document_files << DocumentFile.create(
    document:          doc,
    user:              guest,
    file_name:         "dummy.pdf",
    file_content_type: "application/pdf",
    file_md5:          "c348a159e06d03e9905ed043ab249dda",
    comments:          "hoge",
    download_count:    0
  )
  doc.document_files << DocumentFile.create(
    document:          doc,
    user:              guest,
    file_name:         "ダミー.pdf",
    file_content_type: "application/pdf",
    file_md5:          "e4472dd5992625b5a62c761cd906b6c1",
    comments:          "hoge",
    download_count:    0
  )
end
