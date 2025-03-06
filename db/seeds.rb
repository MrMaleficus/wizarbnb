require 'nokogiri'
require 'open-uri'
require 'net/http'
require 'json'
require 'uri'
require 'dotenv/load'
require 'faker'

NICKS = %w(LouisGoffette
RomainBanyuls
MrMaleficus
Kherset
ibrahimaltinkaynak
cecile-fontaine
TCepparo
BragonTv
Wedge3DSFU
Florent62120
AdrienLobry
nielsenpereira
thomas6791
Dgrvictor
FabLANGRAND
Theo-dpl
maximolivier
touf59
Toavina59000
AnaE29
cecile-dmr
AldjiaDev
meliamzz
TCharlet
Loup59
Gaeus
Mak9231
jkmn-eu
bensouc
JocTe
John-Dav9
Celinamoussaoui
joydfr
Bibou62
Igor-BK
Zukam-fp
Sarkraf
aodrenn-thibault8
remicarette
LamiaS42
sarahasfr
Jeremx-5
jpmacveigh
Alexskq
Washington-1991
CamelW
PaolaCaby
CamilleGUILMAIN
Mathieu-Cozian
ollivierj
Antoine-Heu
Pierre-Antoine59500
AlexBtest
chaudard
lxsrbrcht
sandvng
Nickaos1203
simonchrt
Meyclem
Akleodorion
blepoutre
KarinK59
gautierbar
clemence2
Cyriangda
Personne42
Pyh0rns
alexandre25091991
romainp-git
Mathis2Data
Drussss
Wern-S
Walid-elb
DianeHb
Jonas-D17
arthurDeleval
PYM5
axelperon
rztprog
Hervis59
GabrielVareilles
madeleinebizard
clarabnb
stella-ghis
BNabila
eliesg
GaelR26
Kristybas
fwthom
TimVanBelle
hugorulquin
yainy16
curb320
marccombarel
sschwob
AlexValla59
Adouez
juandelarbol
mick-sudo)


GITHUB_TOKEN = ENV['GITHUB_TOKEN']
all_members = []
#pages = (1..800).to_a.sample(4)
#pages.each do |page|
#  url = URI("https://api.github.com/orgs/lewagon/members?page=#{page}")
#  http = Net::HTTP.new(url.host, url.port)
#  http.use_ssl = true
#  request = Net::HTTP::Get.new(url)
#  request["Authorization"] = "token #{GITHUB_TOKEN}" if GITHUB_TOKEN
#  request["User-Agent"] = "Ruby"
#  p "Construction page #{page} (membres #{all_members.size})"

#  response = http.request(request)
#  members = JSON.parse(response.body)

#  break if members.empty?
#  all_members.concat(members)
#end

#all_members = all_members.map{|member| member["login"].downcase}

NICKS.each do |member|

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
  user.house = %w[red green blue yellow].sample
  user.github_id = profile["id"]
  user.save
  4.times do
    service = Service.new
    service.name = ["JS", "Rust", "Java", "Kotlin", "Ruby", "Python", "Go", "TypeScript", "PHP", "OCaml", "Haskell", "Fortran"].sample
    service.description = Faker::Lorem.paragraph
    service.daily_rate = rand(10..100)
    service.user = user
    service.save
  end
  p "Création de #{user.nickname}"
end