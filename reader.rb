require 'open-uri'
require 'rest-client'
require 'json'
require "vine"

# set API token and URL
token = "$2y$10$Zx.LEihxwRd25tKwTsR1weBs3naVcP0xEhOOk9tIZSXjqBJgiZoq6"
conversation_id = "c-8fca2030-7edd-11e4-a790-5b29cb36bdd0"
# polling_url = "https://api.usekimono.com/api/1/conversation/:conversation_id/read"
polling_url = "https://api.usekimono.com/api/1/conversation/list"


# Specify request parameters
params = {
  token: token,
  conversation_id: conversation_id,
  retvals: "messenger_list,position_date"
}

# Prepare API request
uri = URI.parse(polling_url)
uri.query = URI.encode_www_form(params)

# Submit request
result = JSON.parse(open(uri).read)

# Display results to screen
# puts JSON.pretty_generate result
# puts result
# data = JSON.load result
# puts result["result"] # => success
# @conversation = result["conversations"]
# @state = result["conversations"]["state"]
# puts @conversation
# puts @state
# @state = result[:conversation] && result[:conversation][:state]
# puts result.access("conversations.0")
# puts @state

# puts result["conversation"]
# puts result["recipients"]
# puts result["messages"]

result["conversations"].each do |conversation|
  puts conversation["conversation"]["id"]
  puts conversation["conversation"]["subject"]
  puts conversation["conversation"]["state"]
  puts conversation["conversation"]["messenger_list"]
  conversation["recipients"].each do |recipient|
    puts recipient
  end
end



