<!-- Signature: dev.tswicolly03 -->

# Deploy no servidor de Vinhedo

Este diretorio guarda a configuracao usada para publicar a API do CampusFlow em:

```text
https://tswicolly03.duckdns.org/api
```

## Como publicar pelo Windows

Abra o PowerShell na raiz do projeto e execute:

```powershell
$env:CAMPUSFLOW_SSH_KEY = "<caminho-da-sua-chave-ssh>"
.\backend\deploy\vinhedo\deploy.ps1
```

O script:

- compacta o backend sem `node_modules`, `dist`, `.env` e uploads
- envia o pacote por SSH
- cria ou reutiliza `/opt/campusflow/backend/.env`
- sobe PostgreSQL em Docker na porta local `127.0.0.1:5433`
- instala dependencias, compila TypeScript e aplica o schema Prisma
- cria o servico `campusflow-api` no systemd
- cria o servico `campusflow-firewall` para liberar `80` e `443` no firewall local
- configura o Caddy para expor a API em `/api`

## Acessar o servidor

```powershell
ssh -i "$env:CAMPUSFLOW_SSH_KEY" ubuntu@tswicolly03.duckdns.org
```

## Comandos uteis no servidor

Ver se a API esta rodando:

```bash
sudo systemctl status campusflow-api
```

Ver logs em tempo real:

```bash
sudo journalctl -u campusflow-api -f
```

Reiniciar a API:

```bash
sudo systemctl restart campusflow-api
```

Testar localmente no servidor:

```bash
curl http://127.0.0.1:3333/health
curl http://127.0.0.1:3333/ready
```

Testar pela internet:

```text
https://tswicolly03.duckdns.org/api/health
https://tswicolly03.duckdns.org/api/ready
```

Se esse teste nao abrir, mas `curl http://127.0.0.1:3333/health` funcionar dentro do servidor, falta liberar as portas `80` e `443` tambem no firewall externo da infraestrutura, por exemplo Oracle Cloud Security List/NSG ou redirecionamento de porta do roteador.

## Liberar 80 e 443 na Oracle Cloud

O firewall local do Linux ja fica configurado pelo script. Se o servidor estiver na Oracle Cloud, ainda precisa liberar a entrada na rede da propria Oracle:

1. Entre no painel da Oracle Cloud.
2. Abra `Networking`.
3. Entre em `Virtual Cloud Networks`.
4. Selecione a VCN onde a VM `tsmine` esta.
5. Abra a `Subnet` usada pela VM.
6. Entre em `Security Lists` ou `Network Security Groups`, dependendo de como a VM foi criada.
7. Adicione uma regra de entrada para HTTP:

```text
Source CIDR: 0.0.0.0/0
IP Protocol: TCP
Destination Port Range: 80
Description: CampusFlow HTTP
```

8. Adicione outra regra de entrada para HTTPS:

```text
Source CIDR: 0.0.0.0/0
IP Protocol: TCP
Destination Port Range: 443
Description: CampusFlow HTTPS
```

9. Aguarde alguns minutos e teste:

```text
https://tswicolly03.duckdns.org/api/health
https://tswicolly03.duckdns.org/api/ready
```

Se for um servidor fisico em casa, o equivalente e abrir/redirecionar as portas TCP `80` e `443` no roteador para o IP interno desse servidor.

## Onde ficam os dados

- codigo atual: `/opt/campusflow/backend/current`
- releases antigas: `/opt/campusflow/backend/releases`
- variaveis secretas: `/opt/campusflow/backend/.env`
- uploads/anexos: `/opt/campusflow/backend/storage/uploads`
- banco PostgreSQL: volume Docker `campusflow_postgres`

Nao publique nem envie o arquivo `.env` para ninguem.

## Configurar login com Google

Depois de criar o OAuth Client no Google Cloud, rode no PowerShell:

```powershell
.\backend\deploy\vinhedo\set-google-oauth.ps1 `
  -WebClientId "SEU_WEB_CLIENT_ID.apps.googleusercontent.com"
```

Se houver Client IDs extras para iOS ou outro app:

```powershell
.\backend\deploy\vinhedo\set-google-oauth.ps1 `
  -WebClientId "SEU_WEB_CLIENT_ID.apps.googleusercontent.com" `
  -ExtraClientIds "SEU_IOS_CLIENT_ID.apps.googleusercontent.com,OUTRO_CLIENT_ID.apps.googleusercontent.com"
```

No Google Cloud, o Client ID Web deve ter estes JavaScript origins:

```text
http://localhost:7357
https://tswicolly03.duckdns.org
```

Para rodar o Flutter Web local com a porta fixa:

```powershell
flutter run -d chrome --web-hostname localhost --web-port 7357 `
  --dart-define=GOOGLE_WEB_CLIENT_ID=SEU_WEB_CLIENT_ID.apps.googleusercontent.com
```
