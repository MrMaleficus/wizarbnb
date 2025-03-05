require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'json'
require 'uri'
require 'dotenv/load'
require 'faker'

GITHUB_TOKEN = ENV['GITHUB_TOKEN']
all_members = []
pages = (1..800).to_a.sample(4)
pages.each do |page|
  url = URI("https://api.github.com/orgs/lewagon/members?page=#{page}")
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(url)
  request["Authorization"] = "token #{GITHUB_TOKEN}" if GITHUB_TOKEN
  request["User-Agent"] = "Ruby"
  p "Construction page #{page} (membres #{all_members.size})"

  response = http.request(request)
  members = JSON.parse(response.body)

  break if members.empty?
  all_members.concat(members)
end

all_members = all_members.map{|member| member["login"].downcase}

all_members.each do |member|

  url = URI("https://api.github.com/users/#{member}")

  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true
  request = Net::HTTP::Get.new(url)
  request["Authorization"] = "token #{GITHUB_TOKEN}" if GITHUB_TOKEN
  request["User-Agent"] = "Ruby"

  response = http.request(request)
  profile = JSON.parse(response.body)

  user = User.new
  user.email = "#{member}@test.com"
  user.password = "password"
  user.nickname = member
  user.name = profile["name"]
  user.house = ["red", "green", "blue", "yellow"].sample
  user.github_id = profile["id"]
  user.save
  4.times do
    service = Service.new
    service.name = Faker::ProgrammingLanguage.name
    service.daily_rate = rand(10..100)
    service.user = user
    service.save
  end
  p "Création de #{user.nickname}"
end