class InviteMailer < ActionMailer::Base
  default from: "abhineet95@gmail.com"

  def send_invites(send_to_list, name, score)
  	@user = name
    @url  = 'http://localhost:3000/signup'
    @score = score
    @send_to_list = send_to_list
    mail(to: @send_to_list, subject: 'Challenge to beat '+@user+'\'s score in Play4Connect!')
  end
end
