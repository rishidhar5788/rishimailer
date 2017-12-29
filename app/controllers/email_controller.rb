class EmailController < ApplicationController
	require 'sendgrid-ruby'
	include SendGrid

	skip_before_action :verify_authenticity_token 

  def sendemail
		
		begin
			# Expected body to POST
			#{ to: ‘myemail@example.com’, subject: “hello”, body: “world” }
			if params["subject"] == nil
				render json: "Sending email without subject"
			end

			if params["body"] == nil
				render json: "Sending email without any Body"
			end

			if params[:to] != nil
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
			else
				render json: {error: "No to address specified"}
			end
		rescue Exception => e
			p "Something went wrong with the send, trying to resend email again in 5 mins" + e.to_s
			sleep(5.minutes)
			sendemail
		end
  end
end
