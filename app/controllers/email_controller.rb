class EmailController < ApplicationController
	require 'sendgrid-ruby'
	include SendGrid

	skip_before_action :verify_authenticity_token 

  def sendemail
		data = JSON.parse('{
		  "personalizations": [
		    {
		      "to": [
		        {
		          "email": "rishidhar5788@gmail.com"
		        }
		      ],
		      "subject": "Sending with SendGrid is Fun"
		    }
		  ],
		  "from": {
		    "email": "rishidhar5788@gmail.com"
		  },
		  "content": [
		    {
		      "type": "text/plain",
		      "value": "and easy to do anywhere, even with Ruby"
		    }
		  ]
		}')
		sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
		response = sg.client.mail._("send").post(request_body: data.to_s)
		p response
		p response.status_code
		p response.body
		p response.headers
  end
end
