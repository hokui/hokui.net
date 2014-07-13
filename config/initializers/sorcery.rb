Rails.application.config.sorcery.submodules = [:user_activation, :user_approval, :reset_password, :activity_logging]

Rails.application.config.sorcery.configure do |config|
  config.user_config do |user|
    # NOTE
    # All mails associated with sorcery features must be sent manually in
    # order to avoid confusion in thinking which mails should be sent manually.
    user.activation_mailer_disabled = true
    user.approval_mailer_disabled = true
    user.reset_password_mailer_disabled = true
  end

  config.user_class = "User"
end
