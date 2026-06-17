<!-- Signature: dev.tswicolly03 -->

# Plano B da demonstracao

Use este documento se algo falhar durante a apresentacao. A ideia e manter a
narrativa segura: o CampusFlow e offline-first, entao o app continua util mesmo
quando backend, internet ou Google falham.

## Se o backend nao subir

- Nao tente consertar ao vivo por muito tempo.
- Na tela de login, use `Usar offline`.
- Se ja estiver dentro do app, va em `Ajustes > Servidor e sincronizacao` e use
  `Usar modo local/offline`.
- Mostre dashboard, perfis, disciplinas, aulas, anexos locais, horas e estudos.
- Frase sugerida:

> "A arquitetura foi pensada primeiro para funcionar offline. O backend e uma
> evolucao para multi-dispositivo, mas a experiencia principal nao depende dele."

## Se o PostgreSQL nao subir

- Explique que `/health` pode responder mesmo quando o banco falha.
- Mostre que `/ready` e o endpoint correto para provar banco + storage.
- Continue a demo pelo app offline.
- Depois da apresentacao, rode:

```powershell
cd backend
docker compose up -d postgres
npm run db:push
npm run dev
Invoke-RestMethod http://localhost:3333/ready
```

## Se o Flutter Web falhar

- Rode o app no Windows:

```powershell
flutter run -d windows
```

- Explique que web usa SQLite via WASM/IndexedDB, enquanto desktop usa SQLite
  local via Drift.

## Se o login remoto falhar

- Teste em Ajustes com `Testar conexao`.
- Se falhar, limpe o endpoint e use modo local/offline.
- Evite insistir no Google OAuth; use email e senha.
- Frase sugerida:

> "Login remoto depende da API estar online. Como o app e offline-first, eu
> consigo demonstrar o nucleo do produto sem servidor."

## Se a sincronizacao falhar

- Mostre a fila local em Ajustes.
- Explique que falhas ficam registradas e podem ser reenviadas.
- Use `Descartar fila antiga` apenas se estiver trabalhando com dados antigos de
  teste.
- Seja honesto: o pull remoto ainda nao aplica dados automaticamente no banco
  local.

## Se a internet cair

- Nao use Google OAuth.
- Nao use backend.
- Mostre:
  - dashboard;
  - perfil academico;
  - disciplinas;
  - aulas;
  - anexos locais;
  - atividades complementares;
  - estudos;
  - backup JSON.

## Se o navegador travar

- Abra a build/execucao desktop.
- Se precisar, reduza a demo para estes passos:
  1. login;
  2. dashboard;
  3. perfil;
  4. disciplina com aula e anexo;
  5. backup;
  6. explicacao tecnica pelo codigo.

## Ordem mais segura da demo

1. Login com email/senha.
2. Dashboard.
3. Perfil academico.
4. Disciplinas e aulas.
5. Horas complementares/estagio/extensao.
6. Estudos.
7. Backup JSON.
8. Ajustes com endpoint, sync e plano offline.
9. Backend e `/health`/`/ready`, somente se tudo estiver online.

## O que evitar mostrar se estiver instavel

- Google OAuth se os Client IDs nao estiverem configurados.
- Sync como se fosse multi-dispositivo completa.
- Upload remoto de anexos como funcionalidade final.
- Docker Compose como producao final.
- Logs com `.env`, tokens, JWT ou caminhos de chave privada.

## Frase de fechamento

> "O diferencial tecnico do CampusFlow e ter nascido offline-first, com banco
> local real, backup JSON e arquitetura pronta para backend. Mesmo que uma parte
> remota falhe na demo, o produto principal continua funcionando."
