# Etapa 1: Imagem base
# Usamos uma imagem oficial do Python. A versão 'slim' é menor e ideal para produção.
FROM python:3.10-slim

# Etapa 2: Definir variáveis de ambiente
# Impede o Python de gerar arquivos .pyc e garante que a saída do Python seja enviada diretamente para o terminal.
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Etapa 3: Definir o diretório de trabalho
# Define o diretório de trabalho dentro do container para /app
WORKDIR /app

# Etapa 4: Instalar dependências
# Copia primeiro o arquivo de dependências para aproveitar o cache de camadas do Docker.
# Se o requirements.txt não mudar, o Docker não reinstalará as dependências.
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o código da aplicação
COPY . .

# Etapa 6: Expor a porta em que a aplicação será executada
EXPOSE 8000

# Etapa 7: Comando para executar a aplicação
# Executa o uvicorn. O host 0.0.0.0 torna a aplicação acessível de fora do container.
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]

