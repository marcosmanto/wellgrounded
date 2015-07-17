$LOAD_PATH.unshift File.expand_path('../', __FILE__)
require 'ie_runner'

ier = IERunner.new
ier.visible = true
ier.goto "http://www.google.com/language_tools"
ier.wait_complete(60)

ier.fill_text("source", "fuck off")
# ier.element_by_id("gt-submit").click

# require 'win32ole'
# ie = WIN32OLE.new("InternetExplorer.Application")
# ev = WIN32OLE_EVENT.new(ie)
# ev.on_event("DocumentComplete") {|*args| puts "Loaded document at #{args[1]}"}
# ie.Visible = true
# ie.Navigate "http://srvm612/SCA/Site/Login.aspx?ReturnUrl=%2fscb%2fSite%2fReceita%2fConsultar.aspx"
# while(true)
#   WIN32OLE_EVENT.message_loop
# end