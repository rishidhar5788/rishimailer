class EmailController < ApplicationController
	require 'sendgrid-ruby'
	include SendGrid

	skip_before_action :verify_authenticity_token 

  def sendemail
		# Expected body to POST
		#{ to: ‘myemail@example.com’, subject: “hello”, body: “world” }
		if params["subject"].empty?
			render json: {error: "Expecting subject in request"} and return
		elsif params["body"].empty?
			render json: { error: "Expecting Body in request" } and return
		end

		from = Email.new(email: 'rishidhar5788@gmail.com')
	  subject = params["subject"]
	  to = Email.new(email: params["to"])
	  content = Content.new(type: 'text/plain', value: params["body"])
	  mail = Mail.new(from, subject, to, content)

		if !params[:to].empty?
			sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
		else
			response = sg.client.mail._("send").post(request_body: mail.to_json)
			p mail.to_json
			p response.status_code
			p response.body
			p response.headers
			render json: {
				ERROR: {
					status_code: response.status_code,
					error: response.body
					}
				}
		end
  end
end
