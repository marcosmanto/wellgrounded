str = "The quick, brown fox jumps over a lazy dog. DJs flock by when MTV ax quiz prog. Junk MTV quiz graced by fox whelps. Bawds jog, flick quartz, vex nymphs"
str.gsub!(/[\.,]/,'') # remove pontos e vírgulas
words = str.split # quebra string em array de palavras

#### SOLUÇÃO 1 ####
# h = Hash.new(0) # cria a hash com valor padrão 0.
# result = words.each_with_object(h) do |word, acc|
# 	acc[word] += 1
# end
# result = result.map{|k,v| [k.upcase, v]}.to_h  # transform hash: upcase hash keys

#### SOLUÇÃO 2 ####
# agrupa por palavras e transforma a estrutura do array com o map
result = words.group_by{|word| word}.map{|k,v| [k.upcase, v.size]}

#### DISPLAY RESULT ####
# first(10) seleciona 10 primeiros (TOP 10). Se removido exibe todas palavras.
result.sort_by{|key,value| value}.reverse.first(10).each do |n|
	puts n.join(": ")
end