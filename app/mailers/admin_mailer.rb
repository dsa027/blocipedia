class AdminMailer < Devise::Mailer
  include Devise::Controllers::UrlHelpers
  # default template_path: 'devise/mailer'
  default from: "dsa027@gmail.com"

  def new_user(user)
    headers["Message-ID"] = "<user/#{user.id}@bloccit.com>"
    headers["In-Reply-To"] = "<user/#{user.id}@bloccit.com>"
    headers["References"] = "<user/#{user.id}@bloccit.com>"

    @user = user

    mail(to: @user.email, subject: "Welcome #{@user.email}")
  end

  def confirmation_instructions(record, token, opts={})
    if @user
      headers["Subject"] = "<user/#{@user.email}@bloccit.com>"
      headers["Message-ID"] = "<user/#{@user.id}@bloccit.com>"
      headers["In-Reply-To"] = "<user/#{@user.id}@bloccit.com>"
      headers["References"] = "<user/#{@user.id}@bloccit.com>"
      headers["Custom-header"] = "Blocipedia"
    end
  super
  end
end
