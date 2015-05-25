class UserMailer < ApplicationMailer
	default from: 'no-reply@notefunny.fr'

	def welcome_email(user, temp_password)
		@user = user
		@password = temp_password
		mail(to: @user.email, subject: 'Bienvenue sur noteFunny !')
	end
end
