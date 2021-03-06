require 'win32ole'

class AccessDb
    attr_accessor :mdb, :connection, :data, :fields

    def initialize(mdb=nil)
        @mdb = mdb
        @connection = nil
        @data = nil
        @fields = nil
    end

    def open
        connection_string =  'Provider=Microsoft.ACE.OLEDB.12.0;Data Source='
        connection_string << @mdb
        @connection = WIN32OLE.new('ADODB.Connection')
        @connection.Open(connection_string)
    end

    def query(sql)
        recordset = WIN32OLE.new('ADODB.Recordset')
        # binding.pry
        recordset.Open(sql, @connection)
        @fields = []
        recordset.Fields.each do |field|
            @fields << field.Name
        end
        recordset.MoveFirst
        begin
            @data = recordset.GetRows.transpose
        rescue
            @data = []
        end
        recordset.Close
    end

    def execute(sql)
        @connection.Execute(sql)
    end

    def close
        @connection.Close
    end
end