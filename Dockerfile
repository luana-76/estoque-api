# 1. Imagem base oficial do Node.js, versão leve (Alpine)
FROM node:20-alpine

# 2. Diretório de trabalho dentro do container
WORKDIR /app

# 3. Copia primeiro os arquivos de dependências (aproveita cache do Docker)
COPY package*.json ./

# 4. Instala as dependências mapeadas no package.json
RUN npm install

# 5. Copia o restante do código-fonte da API
COPY . .

# 6. Expõe a porta usada pelo server.js
EXPOSE 3000

# 7. Comando de inicialização padrão do container
CMD ["node", "server.js"]
