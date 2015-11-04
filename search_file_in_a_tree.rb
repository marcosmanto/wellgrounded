# cria uma árvore de diretórios a partir da raiz do sistema (Dir.pwd)
FileUtils.mkpath('/tmp/teste/dir')	

# cria uma árvore de diretórios a partir do diretório onde o programa é executado
FileUtils.mkpath('tmp/teste/dir')

# remove árvore de diretórios a partir da raiz do sistema
FileUtils.rm_r('/tmp')

# remove árvore de diretórios no diretório de execução do programa
FileUtils.rm_r('tmp')

p Dir["spec/*_spec.rb"]			# pesquisa somente na pasta relativa spec
p Dir["spec/*/*_spec.rb"]		# pesquisa somente nas subpastas do dir. spec
p Dir["spec/**/*_spec.rb"]	# pesquisa em toda árvore no dir. relativo spec
