require 'open-uri'
require 'rest-client'
require 'json'
require "vine"
require_relative 'secrets.rb'

# set API token and URL
token = API_TOKEN
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
def show_JSON(result)
  puts JSON.pretty_generate result
end

def display_all(result,state)
  result["conversations"].each do |conversation|
    if conversation["conversation"]["state"] == state
      puts "conversation_id:  #{conversation["conversation"]["id"]}"
      puts "subject:          #{conversation["conversation"]["subject"]}"
      puts "state:            #{conversation["conversation"]["state"]}"
      puts "recipients user:  #{conversation["recipients"]["user"][0]["full_name"]}" if conversation["recipients"]["user"] != []
      puts "recipients group: #{conversation["recipients"]["group"][0]["name"]}" if conversation["recipients"]["group"] != []
      puts "recipients bot:   #{conversation["recipients"]["bot"][0]["name"]}" if conversation["recipients"]["bot"] != []
      puts "messenger_list:   #{conversation["conversation"]["messenger_list"]}"
      i = 0
      conversation["messages"].each do |message|
        puts "  #{i}.  #{conversation["messages"][i]["user"]["full_name"]}: #{conversation["messages"][i]["message"]}"
        i += 1
        # puts "...."
      end
    end
    puts '------------------------'
  end
end

# puts API_TOKEN
display_all(result,"active")
# show_JSON(result)