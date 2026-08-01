# Pesquisa: Instruções do Dockerfile

## FROM
Define a imagem base a partir da qual o container vai ser construído. É sempre a primeira instrução de um Dockerfile, porque tudo o que vem depois é construído em cima dela. No nosso caso, usamos `node:20-alpine`, uma versão oficial do Node.js baseada em Alpine Linux — uma distribuição minimalista que deixa a imagem final bem mais leve do que uma imagem Node completa.

## WORKDIR
Define qual pasta dentro do container vai ser usada como diretório de trabalho para todos os comandos seguintes (`COPY`, `RUN`, `CMD`, etc). Se a pasta não existir, o Docker cria automaticamente. Usar o `WORKDIR` evita ter que escrever caminhos absolutos toda hora e organiza onde o código da aplicação vai morar dentro do container (`/app`, no nosso caso).

## COPY
Copia arquivos e pastas da máquina local (contexto do build) para dentro do container. Copiamos primeiro só o `package*.json` e depois rodamos o `RUN npm install`, e só então copiamos o resto do código com `COPY . .`. Essa ordem é proposital: o Docker cria camadas (layers) e reaproveita cache — se o código mudar mas as dependências não, o Docker não precisa reinstalar tudo de novo, só reconstrói a partir da camada que mudou.

## RUN
Executa um comando durante a construção da imagem (build time), não quando o container já está rodando. Usamos `RUN npm install` para instalar as dependências do projeto (Express, etc.) dentro da imagem, deixando ela pronta pra rodar sem precisar instalar nada depois.

## EXPOSE
Documenta qual porta a aplicação dentro do container vai escutar — no nosso caso, a porta 3000, a mesma usada no `server.js`. É importante deixar claro que o `EXPOSE` não publica a porta pra fora sozinho; ele só informa a intenção. Quem realmente mapeia a porta do container pra máquina local é a flag `-p` no `docker run`.

## CMD
Define o comando padrão que roda quando o container é iniciado (runtime, diferente do `RUN`, que roda no build). Usamos `CMD ["node", "server.js"]` pra que a API suba automaticamente assim que o container for instanciado, sem precisar de nenhum comando manual depois do `docker run`.
