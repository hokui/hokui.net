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

AccessToken.skip_callback(:validation, :before, :generate_token)
AccessToken.create(
  user:  u,
  token: "4ebbcf209ca3625dfe0b2595d627ffacd90f8cefd69722712a451a7c291643af"
)
AccessToken.set_callback(:validation, :before, :generate_token)
