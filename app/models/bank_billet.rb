class BankBillet < ApplicationRecord
  require 'uri'
  require 'net/http'

  def self.list_bank
    url = url_service("/bank_billets?per_page=50")
    response = http_service(url, 'get', '')
    JSON.parse(response.read_body)
  end 
  
  def self.create_bank(params)
    url = url_service("bank_billets")
    response = http_service(url, 'post', params)
    JSON.parse(response.read_body)
  end 

  def self.edit_bank(params_id)
    url = url_service("/bank_billets/#{params_id}")
    response = http_service(url, 'get', params_id)
    JSON.parse(response.read_body)
  end 

  def update_bank(params)
    url = url_service("/bank_billets/#{params_id}")
    response = http_service(url, 'put', params_id)
    JSON.parse(response.read_body)
  end  

  def self.url_service(url_endpoint)
    URI("#{ENV.fetch("KOBANA_ENDPOINT")}/#{url_endpoint}")
  end  

  def self.http_service(url, type_request, params)
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    
    request = request_service(url, type_request)
    request["accept"] = 'application/json'
    request["content-type"] = 'application/json'
    request["authorization"] = "Bearer #{ENV['KOBANA_TOKEN']}"
    
    request_http_service(type_request, params, http, request)
    #retorno
  end  

  def self.request_service(url, type_request)
    if type_request == 'get'
      request = Net::HTTP::Get.new(url)
    elsif type_request == 'post'
      request = Net::HTTP::Post.new(url)
    elsif type_request == 'put'  
      request = Net::HTTP::Put.new(url)
    end  
    request
  end  

  def self.request_http_service(type_request, params, http, request)
    if type_request == 'get' 
      retorno = http.request(request)
    elsif ['post', 'put'].include?(type_request) and params.present?
      request.body = params.to_json
      retorno = http.request(request)
    end
    retorno
  end  

  def self.document_types
    [
      ["CH | Cheque", "01"], 
      ["DM | Duplicata Mercantil (Padrão)", "02"], 
      ["DMI | Duplicata Mercantil p/ Indicação", "03"], 
      ["DS | Duplicata de Serviço", "04"],
      ["DSI | Duplicata de Serviço p/ Indicação", "05"],
      ["DR | Duplicata Rural", "06"],
      ["LC | Letra de Câmbio", "07"],
      ["NCC | Nota de Crédito Comercial", "08"],
      ["NCE | Nota de Crédito a Exportação", "09"],
      ["NCI | Nota de Crédito Industrial", "10"],
      ["NCR | Nota de Crédito Rural", "11"],
      ["NP | Nota Promissória", "12"],
      ["NPR | Nota Promissória Rural", "13"],
      ["TM | Triplicata Mercantil", "14"],
      ["TS | Triplicata de Serviço", "15"],
      ["NS | Nota de Seguro", "16"],
      ["RC | Recibo", "17"],
      ["FAT | Fatura", "18"],
      ["ND | Nota de Débito", 19],
      ["AP | Apólice de Seguro", "20"],
      ["ME | Mensalidade Escolar", "21"],
      ["PC | Parcela de Consórcio", "22"],
      ["NF | Nota Fiscal", "23"],
      ["DD | Documento de Dívida", "24"],
      ["CPR | Cédula de Produto Rural", "25"],
      ["CTR | Contrato", "26"],
      ["CSG | Cosseguros", "27"],
      ["EC | Encargos Condominiais", "28"],
      ["CPS | Conta de Prestação de Serviços", "29"],
      ["WR | Warrant", "30"],
      ["DP | Duplicata Prestação", "31"],
      ["CSR | Cobrança Seriada", "32"],
      ["CAR | Carnê", "33"],
      ["ARE | Apólice Ramos Elementares", "34"],
      ["CC | Cartão de Crédito", "35"],
      ["BDP | Boleto de Proposta", "36"],
      ["NPD | Nota Promissória Direta", "37"],
      ["DAE | Dívida Ativa de Estado", "38"],
      ["DAM | Divida Ativa de Município", "39"],
      ["DAU | Dívida Ativa União", "40"],
      ["CCB | Célula de Crédito Bancário", "41"],
      ["FI | Financiamento", "42"],
      ["RD | Rateio de Despesas", "43"],
      ["DRI | Duplicata Rural p/ Indicação", "44"],
      ["ECI | Encargos Condominiais p/ Indicação", "45"],
      ["Outros | Outros", "99"]
    ]
  end  
end
