class UserMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.send_split_notice.subject
  #
  def send_split_notice(split)
    @payer = split.payer
    @bill = split.bill
    @split = split
    mail to: @payer.email, subject: 'You share of the bill'
  end
end
