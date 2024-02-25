class BankBillet < ApplicationRecord
  require 'uri'
  require 'net/http'

  def self.list_bank
    url = url_service("/bank_billets?per_page=50")
    response = http_service(url, 'get', '')
    JSON.parse(response.read_body)
  end 
  
  def self.create_bank(params)
    require 'uri'
    require 'net/http'

    url = URI("https://api-sandbox.kobana.com.br/v1/bank_billets")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["accept"] = 'application/json'
    request["content-type"] = 'application/json'
    request["authorization"] = 'Bearer kpKb2SZT88ZUdTBZbrVX60PzBDd_ObeN6ElFUwJluw4'
    request.body = params.to_json#"{\"interest_type\":0,\"interest_days_type\":0,\"fine_type\":0,\"discount_type\":0,\"charge_type\":1,\"dispatch_type\":1,\"document_type\":\"02\",\"acceptance\":\"N\",\"ignore_email\":false,\"ignore_sms\":false,\"ignore_whatsapp\":false,\"prevent_pix\":false,\"instructions_mode\":1,\"amount\":100}"

    response = http.request(request)
    puts response.read_body
    # url = url_service("bank_billets")
    # response = http_service(url, 'post', params)
    # JSON.parse(response.read_body)
  end 

  def self.url_service(url_endpoint)
    URI("#{ENV.fetch("KOBANA_ENDPOINT")}/#{url_endpoint}")
  end  

  def self.http_service(url, type_request, params)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = type_request == 'get' ? Net::HTTP::Get.new(url) : Net::HTTP::Post.new(url)
    request["accept"] = 'application/json'
    request["authorization"] = "Bearer #{ENV['KOBANA_TOKEN']}"
    if type_request == 'get' 
      http.request(request)
    elsif type_request == 'post' and params.present?
      # request.body = {
      #   "interest_type": params["interest_type"],
      #   "interest_days_type": params["interest_days_type"],
      #   "fine_type": params["fine_type"],
      #   "discount_type": params["discount_type"],
      #   "charge_type": params["charge_type"],
      #   "dispatch_type": params["dispatch_type"], 
      #   "document_type": params["document_type"],
      #   "acceptance": params["acceptance"], 
      #   "ignore_email": params["ignore_email"],
      #   "ignore_sms": params["ignore_sms"],
      #   "ignore_whatsapp": params["ignore_whatsapp"], 
      #   "prevent_pix": params["prevent_pix"], 
      #   "instructions_mode": params["instructions_mode"], 
      #   "amount": params["amount"]
      # }
      #raise .inspect
      request.body = params.as_json
      response = http.request(request)
      raise response.inspect
    end    
  end  

  def self.document_types
    [["CH | Cheque", "01"], ["DM | Duplicata Mercantil (Padrão)", "02"], ["DMI | Duplicata Mercantil p/ Indicação", "03"], ["DS | Duplicata de Serviço", "04"],["DSI | Duplicata de Serviço p/ Indicação", "05"],["DR | Duplicata Rural", "06"],["LC | Letra de Câmbio", "07"],["NCC | Nota de Crédito Comercial", "08"],["NCE | Nota de Crédito a Exportação", "09"],["NCI | Nota de Crédito Industrial", "10"],["NCR | Nota de Crédito Rural", "11"],["NP | Nota Promissória", "12"],["NPR | Nota Promissória Rural", "13"],["TM | Triplicata Mercantil", "14"],["TS | Triplicata de Serviço", "15"],["NS | Nota de Seguro", "16"],["RC | Recibo", "17"],["FAT | Fatura", "18"],["ND | Nota de Débito", 19],["AP | Apólice de Seguro", "20"],["ME | Mensalidade Escolar", "21"],["PC | Parcela de Consórcio", "22"],["NF | Nota Fiscal", "23"],["DD | Documento de Dívida", "24"],["CPR | Cédula de Produto Rural", "25"],["CTR | Contrato", "26"],["CSG | Cosseguros", "27"],["EC | Encargos Condominiais", "28"],["CPS | Conta de Prestação de Serviços", "29"],["WR | Warrant", "30"],["DP | Duplicata Prestação", "31"],["CSR | Cobrança Seriada", "32"],["CAR | Carnê", "33"],["ARE | Apólice Ramos Elementares", "34"],["CC | Cartão de Crédito", "35"],["BDP | Boleto de Proposta", "36"],["NPD | Nota Promissória Direta", "37"],["DAE | Dívida Ativa de Estado", "38"],["DAM | Divida Ativa de Município", "39"],["DAU | Dívida Ativa União", "40"],["CCB | Célula de Crédito Bancário", "41"],["FI | Financiamento", "42"],["RD | Rateio de Despesas", "43"],["DRI | Duplicata Rural p/ Indicação", "44"],["ECI | Encargos Condominiais p/ Indicação", "45"],["Outros | Outros", "99"]]
  end  
end
