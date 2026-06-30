<!-- Signature: dev.tswicolly03 -->

# Roteiro Demo Release 0.1

## 1. Problema

Estudantes acompanham disciplinas, horas complementares, estudos e documentos em
ferramentas separadas. Isso dificulta saber o que falta para concluir o curso.

## 2. Proposta

CampusFlow centraliza a vida academica em um painel offline-first, com login
local, backup, perfil academico, disciplinas, atividades e estudos.

## 3. Por que offline-first

A demo deve funcionar mesmo sem internet ou backend. O banco local preserva os
dados principais e a API entra como camada de sincronizacao quando disponivel.

## 4. Arquitetura geral

- Flutter Web/Desktop com Riverpod, GoRouter e Material 3.
- Drift/SQLite para persistencia local.
- Backend Node.js/Fastify com Prisma.
- PostgreSQL local via Docker Compose.
- Sync generica por entidades para evolucao futura.

## 5. Banco local

Mostre que o app continua abrindo e usando dados locais. Explique que importacao
e backup reduzem risco durante a apresentacao.

## 6. Backend

Mostre o terminal com `npm run dev` e confirme:

```powershell
curl.exe http://localhost:3333/health
curl.exe http://localhost:3333/ready
```

## 7. PostgreSQL

Mostre o container:

```powershell
cd backend
docker compose ps
```

## 8. API

Teste login demo ou cadastro seguro. Nao exiba tokens no projetor.

## 9. Demo passo a passo

1. Abrir o app no Chrome.
2. Confirmar endpoint ativo `http://localhost:3333`.
3. Criar conta ou entrar com `demo@example.com`.
4. Mostrar Dashboard.
5. Criar ou abrir Perfil academico.
6. Mostrar Disciplinas.
7. Mostrar Horas Comp.
8. Mostrar Estudos/Tarefas.
9. Mostrar Ajustes e endpoint ativo.
10. Mostrar `/health` e `/ready`.

## 10. Implementado

Login local/remoto, dashboard, perfil academico, disciplinas, horas
complementares, estudos, backup/importacao local, backend auth, PostgreSQL,
health/readiness e sync remota basica.

## 11. Parcial

Sync existe como base generica, mas nao deve ser apresentada como sincronizacao
completa entre dispositivos. Google depende de Client ID configurado.

## 12. Proximos passos

Resolver merge de conflitos de sync, melhorar seed visual local, ampliar testes
end-to-end e preparar deploy demo se necessario.

## 13. Plano B se a API falhar

Use `Usar offline`, apresente o app local e mostre prints ou docs da API.

## 14. Plano B se o banco falhar

Reinicie Docker Desktop e rode:

```powershell
cd backend
docker compose up -d postgres
npm run db:push
```

Se nao voltar, apresente modo local/offline.

## 15. Plano B se Flutter Web falhar

Rode novamente:

```powershell
flutter pub get
flutter run -d chrome --dart-define=CAMPUSFLOW_API_BASE_URL=http://localhost:3333
```

Se o Chrome falhar, use build web validado ou prints da pasta `docs`.
