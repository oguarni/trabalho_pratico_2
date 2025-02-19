# 📌 **Projeto Appsmith - Trabalho Prático**  

Este projeto configura um ambiente com **Appsmith** e **PostgreSQL** via **Docker** para facilitar o desenvolvimento e a execução da aplicação.  

---

## **📌 Tecnologias Utilizadas**  

- **[Appsmith](https://www.appsmith.com/)** → Plataforma para desenvolvimento de aplicações low-code.  
- **[PostgreSQL](https://www.postgresql.org/)** → Banco de dados relacional.  
- **[Docker](https://www.docker.com/)** → Gerenciamento de containers para ambiente isolado.  
- **[Docker Compose](https://docs.docker.com/compose/)** → Orquestração dos containers do Appsmith e do banco de dados.  

---

## **🚀 Como Rodar o Projeto**  

### **1 - Clonar o Repositório**  
Primeiro, faça o clone do repositório e entre na pasta do projeto:  

```bash
git clone https://github.com/oguarni/trabalho_pratico_2.git
cd trabalho_pratico_2
```

---

## **📌 Configurar o Ambiente**  

### **2 - Copiar o Arquivo de Configuração**  
Antes de subir o projeto, copie o arquivo de variáveis de ambiente:  

```bash
cp appsmith-backup/data/configuration/docker.env.example appsmith-backup/data/configuration/docker.env
```

Caso necessário, edite **docker.env** e configure suas credenciais.  

---

## **📌 Rodando o Docker**  

### **3 - Subir os Containers do Docker**  
Agora, rode os serviços do Appsmith e PostgreSQL:  

```bash
docker-compose up -d
```

👉 **Isso iniciará o Appsmith na porta 8080 e o PostgreSQL na porta 5432.**  

---

## **📌 Restaurar o Banco de Dados**  

### **4 - Restaurar o PostgreSQL**  
Se o banco de dados estiver vazio, restaure os dados usando o backup:  

```bash
docker exec -i postgres_trabalho pg_restore -U postgres -d trabalho_pratico < appsmith-backup/database-dump/backup.sql
```

👉 **Isso restaurará os dados para o banco de dados `trabalho_pratico` no PostgreSQL.**  

---

🚀 **Agora, o projeto está pronto para ser executado!**

