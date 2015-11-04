require 'mechanize'
require 'benchmark'
require 'pry'


# Benchmark.bm do |x|
#   x.report do

#### GET ####
# a = Mechanize.new { |agent|
#   agent.user_agent_alias = 'Windows IE 9'
#   agent.set_proxy 'marcos.filho:vabruiggcan2014@10.90.2.68', 8080
# }

# a= Mechanize.new
# a.get('http://rn3.antt.gov.br/institucional_rn3.aspx?status=') do |page|
#   frm = page.form_with(:name => 'formInstitucional'){ |frm|
#     frm['log_autenticacao$UserName'] = 'marcos.filhopef'
#     frm['log_autenticacao$Password'] = '123456'
#     # field adicionado não é enviado pelo form, o field não é definido como text
#     frm['__ASYNCPOST'] = 'true'
#   }.submit
# end



#### POST ####

placa = ARGV[0]

a = Mechanize.new { |agent|
  agent.user_agent_alias = 'Windows IE 9'
}
# não há necessidade de enviar ao cookie ho header
# o mechanize após o post grava na cookie jar 
login = a.post('http://rn3.antt.gov.br/institucional_rn3.aspx?status=', {
  "__EVENTTARGET" => "",
  "__EVENTARGUMENT" => "",
  "log_autenticacao$UserName" => "marcos.filhopef",
  "log_autenticacao$Password" => "123456",
  "log_autenticacao$LoginButton" => "OK"},
  {
  "Host" => "rn3.antt.gov.br",
  "User-Agent" => "Mozilla/5.0 (Windows NT 6.1; rv:40.0) Gecko/20100101 Firefox/40.0",
  "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
  "Accept-Language" => "pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3",
  "Accept-Encoding" => "gzip, deflate",
  "Referer" => "http://rn3.antt.gov.br/institucional_rn3.aspx?status=",
  "Connection" => "keep-alive",
  "Content-Type" => "application/x-www-form-urlencoded"
})

# puts a.cookies

consulta_veiculo = a.post('http://rn3.antt.gov.br/system/Modulos/Transportador/tra00001.aspx', {
  "__EVENTTARGET" => "ctl00$cph$bb_consultar",
  "__EVENTARGUMENT" => "0",
  "ctl00$smRN3" => "ctl00$cph$upConsultar|ctl00$cph$bb_consultar",
  "ctl00$cph$PlacaRenavam" => "rdbPlaca",
  "ctl00$cph$txtVeiPlaca" => "#{placa}",
  # "__ASYNCPOST" => "true",
  "ctl00$cph$txtVeiRenavam" => ""
  },
  {
  "Host" => "rn3.antt.gov.br",
  "User-Agent" => "Mozilla/5.0 (Windows NT 6.1; rv:40.0) Gecko/20100101 Firefox/40.0",
  "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
  "Accept-Language" => "pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3",
  "Accept-Encoding" => "gzip, deflate",
  "Referer" => "http://rn3.antt.gov.br/institucional_rn3.aspx?status=",
  "Connection" => "keep-alive",
  "Content-Type" => "application/x-www-form-urlencoded"
})


viewstate =  a.page.forms.first['__VIEWSTATE']
viewstategenerator = a.page.forms.first['__VIEWSTATEGENERATOR']

consulta_veiculo_protocolo = a.post('http://rn3.antt.gov.br/system/Modulos/Transportador/tra00001.aspx', {
  "ctl00$smRN3" => "ctl00$cph$upPainelResultado|ctl00$cph$ctrlProtocolo$bb_imprimirProtocolo",
  "__EVENTTARGET" => "ctl00$cph$ctrlProtocolo$bb_imprimirProtocolo",
  "__EVENTARGUMENT" => "0",
  "ctl00$cph$PlacaRenavam" => "rdbPlaca",
  "ctl00$cph$txtVeiPlaca" => "#{placa}",
  "ctl00$cph$txtVeiRenavam" => "",
  "ctl00$cph$hidIdTransportador" => "7636",
  "__VIEWSTATE" => "#{viewstate}",
  "__VIEWSTATEGENERATOR" => "#{viewstategenerator}",
  "__ASYNCPOST" => "true"
  },
  {
  "Host" => "rn3.antt.gov.br",
  "Origin" => "http://rn3.antt.gov.br",
  "X-MicrosoftAjax" => "Delta=true",
  "User-Agent" => "Mozilla/5.0 (Windows NT 6.1; rv:40.0) Gecko/20100101 Firefox/40.0",
  "Accept" => "*/*",
  "Referer" => "http://rn3.antt.gov.br/system/Modulos/Transportador/tra00001.aspx",
  "Accept-Language" => "pt-BR,pt;q=0.8,en-US;q=0.6,en;q=0.4",
  "Accept-Encoding" => "gzip, deflate",
  "Content-Type" => "application/x-www-form-urlencoded; charset=UTF-8"
})
a.get('http://rn3.antt.gov.br/system/Modulos/Transportador/ImpressaoProtocolo.aspx')#.save_as 'protocolo.html'
binding.pry


# puts a.cookies
p = Nokogiri::HTML(a.page.body)
veiculo = p.at_css('#ctl00_cph_pnResultado')
propriedade = p.at_css('#ctl00_cph_pnResultadoTra')

puts

if veiculo
  print "Propriedade:".ljust(25)
  puts veiculo.at_css('#ctl00_cph_lblVeiPropriedade').text
end

if propriedade
  tipo = propriedade.at_css('#ctl00_cph_lblTipoTransportador').text
  print "Tipo transportador:".ljust(25)
  puts tipo

  print "Nome transportador:".ljust(25)
  puts propriedade.at_css('#ctl00_cph_lblNome').text

  print (tipo == "TAC"  ? "CPF: " : "CNPJ: ").ljust(25)
  identificador = propriedade.at_css('#ctl00_cph_lblCPFCNPJ').text
  puts identificador

  consulta_transportador = a.post('http://rn3.antt.gov.br/system/Modulos/Transportador/tra00003.aspx', {
    "__EVENTTARGET" => "ctl00$cph$bb_consultar",
    "__EVENTARGUMENT" => "0",
    "ctl00$smRN3" => "ctl00$cph$upConsultaTransportador|ctl00$cph$bb_consultar",
    "ctl00$cph$txtCpfCnpj" => "#{identificador}",
    "ctl00$cph$txtNome" => "",
    "ctl00$cph$txtRNTRC" => ""},
    {
    "Host" => "rn3.antt.gov.br",
    "User-Agent" => "Mozilla/5.0 (Windows NT 6.1; rv:40.0) Gecko/20100101 Firefox/40.0",
    "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    "Accept-Language" => "pt-BR,pt;q=0.8,en-US;q=0.5,en;q=0.3",
    "Accept-Encoding" => "gzip, deflate",
    "Origin" => "http://rn3.antt.gov.br",
    "Referer" => "Referer: http://rn3.antt.gov.br/system/Modulos/Transportador/tra00003.aspx",
    "Connection" => "keep-alive",
    "Content-Type" => "application/x-www-form-urlencoded"
  })

  print "Situação transportador:".ljust(25)
  puts consulta_transportador.parser.at_css('#ctl00_cph_ctrlRNTRC_lblSituacaoRntrc').text

  print "Total de veículos:".ljust(25)

  aba_veiculo = "#ctl00_cph_tabTransportador#{tipo == "TAC"  ? "Autonomo" : "Empresa"}_tabVeiculo#{tipo == "TAC"  ? "s" : ""}"

  puts consulta_transportador.parser.css("#{aba_veiculo} #tbrSecaoRepeater_subTitle").text.strip.match(/\((\d+)\)/).to_a.last


end






# propr = p.xpath('//div[@title="divSemDados"]').text

# puts propr.empty? ? p.css('#ctl00_cph_lblVeiPropriedade').text : propr.split.join(' ')

# puts page.inspect

# end
# end


