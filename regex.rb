# /x{5}/			# Match 5 xs
# /x{5,7}/		# Match 5-7 xs
# /x{,8}/			# Match UP TO 8 xs
# /x{3,}/			# Match AT LEAST 3 xs

# /x?/				# same as /x{0,1}/
# /x*/				# same as /x{0,}
# /x+/				# same as /x{1,}

# /[a-mA-M]/	# Any letter in the first half of the alphabet
# /[^a-mA-M]/	# Any OTHER letter, or number, or non-alphanumeric character

##### REMOÇÃO DE ESPAÇOS DUPLICADOS #####
str = "Collaboratively    administrate        empowered       markets     via     plug-and-play      networks"
# remove espaços duplicados.
# \s representa espaço
# {2,} siginifica no mínimo 2 ou mais espaços
str.gsub!(/\s{2,}/," ")

puts str


##### ALTERAÇÃO DA ORDEM DE PALAVRAS EM UMA STRING  #####
str = "I breathe when I sleep"
# Numbered matches…
r1 = /I (\w+) when I (\w+)/
s1 = str.sub(r1,'I \2 when I \1')
# Named matches…
r2 = /I (?<verb1>\w+) when I (?<verb2>\w+)/
s2 = str.sub(r2,'I \k<verb2> when I \k<verb1>')

puts s1 # I sleep when I breathe
puts s2 # I sleep when I breathe

##### NAMED MATCHES #####
str = "My hovercraft is full of eels"
reg = /My (?<noun>\w+) is (?<predicate>.*)/
m = reg.match(str)
puts m[:noun] # hovercraft
puts m["predicate"] # full of eels
puts m[1] # same as m[:noun] or m["noun"]


##### POSITIVE LOOKBEHIND #####
# caso: Procurar as sequencias  de nucletídeos não sobrepostas após um T numa cadeia genética
gene = 'GATTACAAACTGCCTGACATACGAA'
seqs = gene.scan(/T(\w{4})/)
# seqs is: [["TACA"], ["GCCT"], ["ACGA"]]
# scan faz uma pesquisa da esquerda p/ direita. Mas nesta orientação de varredura,
# a sequencia "GACA" é perdida já que seu T antecessor é o último caracter do match anterior

# a solução deste caso é usar uma varredura da direita para esquerda: positive lookbehind
seqs = gene.scan(/(?<=T)(\w{4})/)
# seqs is: [["TACA"], ["GCCT"], ["GACA"], ["ACGA"]]


##### EXEMPLO: PADRÃO DE ENDEREÇO #####
# com uso de named params isola-se dados relevantes no endereço
pat = / ^											# Beginning of string
(No.?\s+)?										# Optional: No[.]
(?<rua_no>\d+)\s+ 						# Digits and spacing
(?<rua_name>([\w.'-]+\s*)+)		# Street name… may be multiple words
(?<complemento>,\s* 					# Optional: Comma etc.
(Apt.?|Suite|\#) 							# Apt[.] or Suite or #
\s+ 													# Spacing
(?<residencia_no>\d+|[A-Z]) 	# Numbers or single letter
)?
$ 														# End of string
/x														# The x directive enables you to stretch out a regex across multiple lines; spaces and newlines are ignored

_addresses =
[ "409 W Jackson Ave", "No. 27 Grande Place",
"16000 Pennsylvania Avenue", "2367 St. George St.",
"22 Rue Morgue", "33 Rue St. Denis",
"44 Rue Zeeday", "55 Santa Monica Blvd.",
"123 Main St., Apt. 234", "123 Main St., #234",
"345 Euneva Avenue, Suite 23", "678 Euneva Ave, Suite A"]

pat.match("678 Euneva Ave, Suite A")
# 	=> #<MatchData
#  	"678 Euneva Ave, Suite A"
#  	rua_no:"678"
#  	rua_name:"Euneva Ave"
#  	complemento:", Suite A"
#  	residencia_no:"A">