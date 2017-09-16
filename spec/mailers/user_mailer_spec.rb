require 'rails_helper'

RSpec.describe 'Sending Notification to payers', type: :mailer do
  let(:split) { create(:split) }

  let(:mail) do
    UserMailer.send_split_notice(split)
  end

  it 'send email to the first payer of the split' do
    expect(mail.to).to include split.payer.email
    expect(mail.subject).to include 'You share of the bill'
  end

  it 'contains the title and amount of the bill' do
    expect(mail.body.encoded).to match "Bill: #{split.bill.title}"
    expect(mail.body.encoded).to match "#{split.amount}"
  end

  it 'send email NOT to be sent to receiver' do
    expect(mail.to).not_to include split.payee.email
  end
end
