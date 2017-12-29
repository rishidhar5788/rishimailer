class EmailController < ApplicationController
	require 'sendgrid-ruby'
	include SendGrid

	skip_before_action :verify_authenticity_token 

  def sendemail
		# Expected body to POST
		#{ to: ‘myemail@example.com’, subject: “hello”, body: “world” }
		
	  from = Email.new(email: 'rishidhar5788@gmail.com')
	  subject = params["subject"]
	  to = Email.new(email: params["to"])
	  content = Content.new(type: 'text/plain', value: params["body"])
	  mail = Mail.new(from, subject, to, content)
	  puts mail.to_json

		sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
		response = sg.client.mail._("send").post(request_body: mail.to_json)
		p response.status_code
		p response.body
		p response.headers
  end
end
