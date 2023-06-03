#!/bin/bash

PURPLE='0;35'
NC='\033[0m' 
VERSAO=17

SQL=" \
use renderwatch;\

CREATE TABLE componente (\
  id INT PRIMARY KEY AUTO_INCREMENT,\
  nome VARCHAR(150),\
  descricao VARCHAR(150),\
  modelo VARCHAR(150),\
  total DOUBLE,\
  identificador VARCHAR(150),\
  tipo VARCHAR(150),\
  frequencia DOUBLE,\
  maquina_id INT\
);\
\
CREATE TABLE registro_componente (\
  id INT PRIMARY KEY AUTO_INCREMENT,\
  em_uso DOUBLE,\
  dt_hora DATETIME,\
  componente_id INT\
);\
\
CREATE TABLE rede (\
  id INT PRIMARY KEY AUTO_INCREMENT,\
  nome VARCHAR(100),\
  ipv4 LONGTEXT,\
  ipv6 LONGTEXT,\
  nome_dominio VARCHAR(100),\
  maquina_id INT\
);\
\
CREATE TABLE grupo_processos (\
  id INT PRIMARY KEY AUTO_INCREMENT,\
  lista_processos LONGTEXT,\
  total_threads INT,\
  total_processos INT,\
  dt_hora DATETIME,\
  dt_inicializado DATETIME,\
  tempo_atividade VARCHAR(45),\
  maquina_id INT\
);\
"

echo  "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Olá usuário, sou o RenderBot e serei seu assistente de instalação do RenderWatch!"
sleep 2
echo  "$(tput setaf 161)[RenderBot]:$(tput setaf 0)  Para usar o RenderWatch é necessário ter o Java instalado em sua máquina"
sleep 2
echo  "$(tput setaf 161)[RenderBot]:$(tput setaf 0)  Vou verificar aqui se você já possuí o java instalado..."
sleep 2

java -version
if [ $? = 0 ]
	then
		echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) : Otimo! Você já está com o Java instalado em sua máquina :D"
		sleep 2

		echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Deseja prosseguir com a instalação do RenderWatch? (Y/n)"
			read resp
			if [ \"$resp\" == \"Y\" ]
				then

				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0)  Atualizando pacotes do sitema"
				sleep 2
				sudo apt update && sudo apt upgrade –y;
				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0)  Instalando Docker na EC2"
				sleep 2
				sudo apt install docker.io
				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0)  Ativando serviço do docker"
				sleep 2
				sudo systemctl start docker
				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Habilitando serviço"
				sudo systemctl enable docker

				sudo docker pull mysql:5.7

				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Confirmando download"
				sleep 2
				sudo docker images

				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Criando container do MySQL"
				sleep 2
				sudo docker run -d -p 3306:3306 --name ContainerBD -e "MYSQL_DATABASE=renderwatch" -e "MYSQL_ROOT_PASSWORD=urubu100" mysql:5.7

				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Acessando o container, aguarde um momento..."
				sleep 2
				sudo docker exec -i ContainerBD sh -c "sleep 15 && mysql -u root -purubu100 <<< '$SQL'"

					ls | grep "*.jar"
        			if [ $? = 0 ];
						then
							sudo find -name 'renderwatch-jar-1.0-SNAPSHOT-jar-with-dependencies.jar' -delete
					fi
					echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Baixando RenderWatch, aguarde um momento"
					sleep 3

					wget https://raw.githubusercontent.com/RenderWatch/RenderWatchJAR/main/renderwatch-jar-1.0-SNAPSHOT-jar-with-dependencies.jar
					wget https://raw.githubusercontent.com/RenderWatch/RenderWatchJAR/main/renderwatch-jar-1.0-SNAPSHOT-jar-cli.jar
					
					
					echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) RenderWatch instalado com sucesso!"		
					sleep 2
					
					clear
						
					echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Digite (1) caso queira executar a versão COM interface gráfica"
					echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Digite (2) caso queira executar a versão SEM interface gráfica"
					
					read selecao 
					
					if [ \"$selecao\" == \"1\" ]; then
							echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0)  Executando RenderWatch com Interface gráfica!"
							sleep 3
							java -jar renderwatch-jar-1.0-SNAPSHOT-jar-with-dependencies.jar
						fi

							
						if [ \"$selecao\" == \"2\" ]; then
							echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0)  Executando RenderWatch sem Interface gráfica!"
							sleep 3
							java -jar renderwatch-jar-1.0-SNAPSHOT-jar-cli.jar
						fi
				else 
					echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0)  Processo de instalação cancelado. Até mais!"
			fi

	else
		echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0)  Não encontrei o Java instalado em sua máquina, mas posso instalar ele para você!"
		sleep 2
		echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0)  Confirme para mim se deseja instalar o Java (Y/n)?"		
		read inst
		if [ \"$inst\" == \"Y\" ];
			then
				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Beleza! Vou começar a instalação..."
				sleep 2
				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Preparando para instalar a versão 17 do Java..."
				sleep 1
				sudo apt install openjdk-17-jre -y
				
				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Pronto! Java instalado com sucesso!"
				sleep 1

				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Deseja prosseguir com a instalação do RenderWatch? (Y/n)"
				read resp
				if [ \"$resp\" == \"Y\" ];

				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0)  Atualizando pacotes do sitema"
				sleep 2
				sudo apt update && sudo apt upgrade –y;
				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0)  Instalando Docker na EC2"
				sleep 2
				sudo apt install docker.io
				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0)  Ativando serviço do docker"
				sleep 2
				sudo systemctl start docker
				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Habilitando serviço"
				sudo systemctl enable docker

				sudo docker pull mysql:5.7

				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Confirmando download"
				sleep 2
				sudo docker images

				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Criando container do MySQL"
				sleep 2

				sudo docker run -d -p 3306:3306 --name ContainerBD -e "MYSQL_DATABASE=renderwatch" -e "MYSQL_ROOT_PASSWORD=urubu100" mysql:5.7

				echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Estou acessando o container, aguarde um momento..."
				sleep 2
				sudo docker exec -i ContainerBD sh -c "sleep 15 && mysql -u root -purubu100 <<< '$SQL'"
			
					then
						ls | grep "*.jar"
						if [ $? = 0 ];
							then
								sudo find -name 'renderwatch-jar-1.0-SNAPSHOT-jar-with-dependencies.jar' -delete
						fi
						echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Baixando RenderWatch, aguarde um momento"
						sleep 3
						wget https://raw.githubusercontent.com/RenderWatch/RenderWatchJAR/main/renderwatch-jar-1.0-SNAPSHOT-jar-with-dependencies.jar
						wget https://raw.githubusercontent.com/RenderWatch/RenderWatchJAR/main/renderwatch-jar-1.0-SNAPSHOT-jar-cli.jar
			
						sleep 3
						
						echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) RenderWatch instalado com sucesso!"		
						sleep 2
						
						clear
						
						echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Digite (1) caso queira executar a versão COM interface gráfica"
						echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Digite (2) caso queira executar a versão SEM interface gráfica"
						
						read selecao
						
						echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Digite (1) caso queira executar a versão COM interface gráfica"
							echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0) Digite (2) caso queira executar a versão SEM interface gráfica"

							read selecao

							if [ \"$selecao\" == \"1\" ]; then
							    echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0)  Executando RenderWatch com Interface gráfica!"
							    sleep 3
							    java -jar renderwatch-jar-1.0-SNAPSHOT-jar-with-dependencies.jar
							fi

							if [ \"$selecao\" == \"2\" ]; then
							    echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0)  Executando RenderWatch sem Interface gráfica!"
							    sleep 3
							    java -jar renderwatch-jar-1.0-SNAPSHOT-jar-cli.jar
							fi
												
					else 
						echo "$(tput setaf 161)[RenderBot]:$(tput setaf 0)  Processo de instalação cancelado. Até mais!"
				fi

			else 	
				echo "$(tput setaf 16)[RenderBot]:$(tput setaf 0)  Você não deseja instalar o Java no momento... Entendi, até mais!"
			sleep 1
		fi
fi