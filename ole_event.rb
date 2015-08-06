require 'win32ole'

xl = WIN32OLE.new('Excel.Application')
xl.visible = true
wb = xl.Workbooks.add

ev = WIN32OLE_EVENT.new(wb, 'WorkbookEvents')

ev.on_event('SheetSelectionChange') do
    range = xl.Selection
    puts(range.Value)
    STDOUT.flush()
end

ev.on_event('BeforeClose') do
    puts('Closed');STDOUT.flush
    exit_event_loop
end

$LOOP = true

def exit_event_loop
    $LOOP = false
end

while $LOOP
    WIN32OLE_EVENT.message_loop
    sleep(0.1)
end
