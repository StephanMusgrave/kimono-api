require 'open-uri'
require 'rest-client'
require 'JSON'

# set API token and URL
token = "$2y$10$Zx.LEihxwRd25tKwTsR1weBs3naVcP0xEhOOk9tIZSXjqBJgiZoq6"
conversation_id = "c-8fca2030-7edd-11e4-a790-5b29cb36bdd0"
# polling_url = "https://api.usekimono.com/api/1/conversation/:conversation_id/read"
polling_url = "https://api.usekimono.com/api/1/conversation/list"


# Specify request parameters
params = {
  token: token,
  conversation_id: conversation_id
}

# puts token
# puts conversation_id
# puts polling_url

# Prepare API request
uri = URI.parse(polling_url)
uri.query = URI.encode_www_form(params)

# Submit request
result = JSON.parse(open(uri).read)

# Display results to screen
puts JSON.pretty_generate result

# data = JSON.load result