# curl -i \
# -H "Authorization: Bearer kpKb2SZT88ZUdTBZbrVX60PzBDd_ObeN6ElFUwJluw4" \
# -H 'Content-Type: application/json' \
# -H 'User-Agent: Meu e-Commerce (meuecommerce@example.com)' \
# -X GET 'https://api-sandbox.kobana.com.br/v1/userinfo'

# https://app-sandbox.kobana.com.br/conta/api/tokens

#####################################listar###################################################
# require 'uri'
# require 'net/http'

# url = URI("https://api-sandbox.kobana.com.br/v1/bank_billets?per_page=50")

# http = Net::HTTP.new(url.host, url.port)
# http.use_ssl = true

# request = Net::HTTP::Get.new(url)
# request["accept"] = 'application/json'
# request["authorization"] = 'Bearer kpKb2SZT88ZUdTBZbrVX60PzBDd_ObeN6ElFUwJluw4'

# response = http.request(request)
# puts response.read_body

######################################criar##################################################

require 'uri'
require 'net/http'

url = URI("https://api-sandbox.kobana.com.br/v1/bank_billets")

http = Net::HTTP.new(url.host, url.port)
http.use_ssl = true

request = Net::HTTP::Post.new(url)
request["accept"] = 'application/json'
request["content-type"] = 'application/json'
request["authorization"] = 'Bearer kpKb2SZT88ZUdTBZbrVX60PzBDd_ObeN6ElFUwJluw4'
request.body = "{\"interest_type\":0,\"interest_days_type\":0,\"fine_type\":0,\"discount_type\":0,\"charge_type\":1,\"dispatch_type\":1,\"document_type\":\"02\",\"acceptance\":\"N\",\"ignore_email\":false,\"ignore_sms\":false,\"ignore_whatsapp\":false,\"prevent_pix\":false,\"instructions_mode\":1,\"amount\":100}"

response = http.request(request)
puts response.read_body