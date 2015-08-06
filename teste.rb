require 'win32ole'
wmi = WIN32OLE.connect("winmgmts://")
processes = wmi.ExecQuery("select * from win32_process")
for process in processes do
    puts "Name: #{process.Name}"
    puts "CommandLine: #{process.CommandLine}"
    puts "CreationDate: #{process.CreationDate}"
    puts "WorkingSetSize: #{process.WorkingSetSize}"
    puts
    break
end