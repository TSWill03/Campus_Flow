<!-- Signature: dev.tswicolly03 -->

# Checklist Demo Release 0.1

## Antes da apresentacao

```text
[ ] docker aberto
[ ] Postgres rodando
[ ] backend rodando
[ ] /health respondendo
[ ] /ready respondendo
[ ] Flutter rodando no Chrome
[ ] dados demo prontos
[ ] navegador limpo
[ ] terminal com comandos prontos
[ ] plano B aberto
```

## Comandos rapidos

Subir banco:

```powershell
cd backend
docker compose up -d postgres
docker compose ps
```

Preparar Prisma:

```powershell
cd backend
npm run db:generate
npm run db:push
```

Rodar backend:

```powershell
cd backend
npm run dev
```

Testar API:

```powershell
curl.exe http://localhost:3333/health
curl.exe http://localhost:3333/ready
```

Criar dados demo no backend:

```powershell
cd backend
npm run demo:seed
```

Resetar dados demo do backend:

```powershell
cd backend
npm run demo:reset
npm run demo:seed
```

Rodar app:

```powershell
flutter run -d chrome --dart-define=CAMPUSFLOW_API_BASE_URL=http://localhost:3333
```

Build web demo:

```powershell
flutter build web --release --dart-define=CAMPUSFLOW_API_BASE_URL=http://localhost:3333
```

Verificar logs:

```powershell
cd backend
docker compose logs postgres --tail=80
```

Checklist automatizado:

```powershell
.\scripts\check_demo.ps1
```

## Ordem sugerida no dia

1. Abrir Docker Desktop.
2. Subir Postgres.
3. Rodar `npm run db:push`.
4. Rodar `npm run demo:seed`.
5. Rodar `npm run dev`.
6. Testar `/health` e `/ready`.
7. Rodar Flutter no Chrome.
8. Entrar ou criar conta demo.
9. Mostrar dashboard e plano B offline.
