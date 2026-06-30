<!-- Signature: dev.tswicolly03 -->

# Comandos de apresentacao - CampusFlow

Esta pasta junta os comandos de palco para demonstrar o app, subir backend,
abrir o Flutter Web e validar a API sem expor tokens no projetor.

Rode os comandos abaixo a partir da raiz do projeto:

```powershell
cd C:\Users\Usuario\Documents\Codex\CampusFlow\Campus_Flow
```

## Fluxo recomendado

Use tres terminais.

Terminal 1 - preparar dependencias, banco e dados demo:

```powershell
.\apresentação\00-preparar-demo.ps1 -SeedDemo
```

Terminal 2 - deixar a API rodando:

```powershell
.\apresentação\01-subir-backend.ps1
```

Terminal 3 - abrir o app no Chrome apontando para a API local:

```powershell
.\apresentação\02-subir-app-web.ps1
```

Em qualquer terminal - testar a API local:

```powershell
.\apresentação\03-testar-api.ps1
```

Teste extra de upload/listagem/exclusao logica de arquivos:

```powershell
.\apresentação\03-testar-api.ps1 -TestFiles
```

## Comandos rapidos para mostrar na banca

Health e readiness:

```powershell
curl.exe http://localhost:3333/health
curl.exe http://localhost:3333/ready
```

Container do PostgreSQL:

```powershell
cd backend
docker compose ps
```

Conta demo:

```text
Email: demo@example.com
Senha: SenhaDemo123!
```

## Usar API publicada

Testar a API publicada:

```powershell
.\apresentação\03-testar-api.ps1 -ApiUrl "https://tswicolly03.duckdns.org/api"
```

Abrir o app apontando para a API publicada:

```powershell
.\apresentação\02-subir-app-web.ps1 -ApiUrl "https://tswicolly03.duckdns.org/api"
```

## Checagem completa antes da apresentacao

Este comando roda geracao, analyze, testes Flutter, build Web, build/testes do
backend e checks de API. Pode demorar.

```powershell
.\apresentação\04-checagem-completa.ps1
```

Se o PostgreSQL ja estiver rodando:

```powershell
.\apresentação\04-checagem-completa.ps1 -SkipDocker
```

## Plano B

Se a API falhar durante a apresentacao:

```powershell
.\apresentação\02-subir-app-web.ps1 -ApiUrl ""
```

No app, use o modo local/offline. Depois mostre os endpoints pelos docs ou
tente reiniciar apenas o backend:

```powershell
.\apresentação\01-subir-backend.ps1
```

