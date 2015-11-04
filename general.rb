##### COMBINAÇÃO DE RANGES #####
# combina ranges em um array, sorteia uma cadeia aleatória de 10 caracteres alfaniméricos
# o operador splat '*' fax a conversão do range em array

[*'0'..'9', *'a'..'z', *'A'..'Z'].sample(10).join



