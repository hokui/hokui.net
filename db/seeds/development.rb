gy = GraduationYear.create(year: 2017)

u = User.create(
  email:              "admin@ec.hokudai.ac.jp",
  password:           "admin",
  family_name:        "admin",
  given_name:         "admin",
  handle_name:        "admin",
  birthday:           "1990-01-01",
  email_mobile:       "admin@example.com",
  graduation_year_id: gy.id,
  admin:              true
)
u.activate!
u.approve!
