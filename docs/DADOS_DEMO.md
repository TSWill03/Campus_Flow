<!-- Signature: dev.tswicolly03 -->

# Dados de Demonstracao

Dados ficticios para a CampusFlow Demo Release 0.1. Nao usar dados pessoais reais.

## Conta demo

```text
Usuario: Demo CampusFlow
Email: demo@example.com
Senha: SenhaDemo123!
Curso: Ciencia da Computacao
Campus: IF Goiano - Campus Morrinhos
```

## Dados sugeridos para mostrar no app

```text
Disciplina: Estrutura de Dados
Atividade complementar: Campus Party / Evento academico
Tarefa de estudo: Revisar listas de Matematica Discreta
```

## Seed local do backend

Com PostgreSQL rodando e `.env` configurado:

```powershell
cd backend
npm run db:push
npm run demo:seed
```

O script recria apenas o usuario `demo@example.com` e dados de sync ficticios
ligados a esse usuario. Ele nao toca em outros usuarios.

Para remover apenas a conta demo:

```powershell
cd backend
npm run demo:reset
```

## Observacao importante

O app e offline-first. O seed do backend valida API, auth, PostgreSQL e sync
remota, mas a tela local do Flutter continua dependendo do banco local do
navegador/dispositivo. Para uma apresentacao visual rica, cadastre os dados pelo
proprio app ou importe um backup local preparado antes da banca.
