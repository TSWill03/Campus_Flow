<!-- Signature: dev.tswicolly03 -->

# Roteiro de demonstracao

Este roteiro ajuda a apresentar o CampusFlow sem depender de improviso. Antes da
apresentacao, rode o app, confirme que o backend esta online se for usar sync e
deixe alguns dados de exemplo preparados.

## Preparacao antes da aula

- Abrir o projeto no VS Code ou Android Studio.
- Rodar `flutter pub get`.
- Rodar `flutter analyze`.
- Rodar `flutter test`.
- Abrir o app em Windows ou Chrome.
- Testar `https://tswicolly03.duckdns.org/api/health` se for mostrar backend.
- Testar `https://tswicolly03.duckdns.org/api/ready` se for provar banco e storage.
- Ter um PDF/PPC pequeno ou dados de exemplo para importacao.

## Dados ficticios para preencher se precisar

- Usuario: `Aluno Demo`, `demo@example.com`, senha `SenhaDemo123!`.
- Perfil: `Ciencia da Computacao`, `Universidade Demo`, campus `Principal`,
  3200 horas, 8 semestres, 120 horas complementares, 300 de estagio e 320 de
  extensao.
- Disciplina: `Algoritmos e Programacao de Computadores`, 72 horas, periodo 1,
  status `Cursando`.
- Aula: `Aula 1`, 4 horas, conteudo `Variaveis, tipos primitivos e estruturas
  de decisao`.
- Atividade complementar: `Semana Academica Demo`, 20 horas, status `Validado`.
- Tarefa de estudo: `Resolver lista de algoritmos`, prazo para a proxima semana,
  prioridade alta.
- Sessao de estudo: 1h30min revisando algoritmos.

## Demo principal

### 1. Entrada no app

Mostre a tela de login e explique:

- Existe login com email e senha.
- A senha e protegida com hash/armazenamento seguro.
- O login com Google foi preparado para plataformas compativeis.
- Se o servidor estiver indisponivel, o proprio login permite usar modo
  local/offline para continuar a demo.

### 2. Dashboard

Mostre o dashboard e explique:

- Ele resume progresso do curso, horas obrigatorias e estudos.
- Os indicadores dependem do perfil academico ativo.
- O app suporta mais de um perfil academico.

### 3. Perfil academico

Crie ou mostre um perfil com:

- Curso.
- Instituicao.
- Faculdade/escola.
- Campus.
- Nivel, como graduacao, segunda graduacao, mestrado ou doutorado.
- Horas complementares, estagio e extensao obrigatorias.

### 4. Importacao de grade

Mostre a importacao de um PPC/PDF ou explique com um preview ja pronto:

- O app tenta extrair disciplinas.
- Ele identifica carga horaria, periodo, tipo e pre-requisitos.
- Ao atualizar um perfil existente, ele pode evitar duplicacoes e remover itens
  antigos quando o usuario escolher.

### 5. Aproveitamento de disciplinas

Explique o caso de segunda graduacao:

- O aluno ja tem materias de outro perfil.
- A nova matriz e comparada com disciplinas antigas.
- O app sugere equivalencia por nome, ementa e carga horaria.
- Isso ajuda a visualizar possiveis aproveitamentos.

### 6. Disciplinas e aulas

Abra uma disciplina e mostre:

- Status da disciplina.
- Pre-requisitos.
- Horario semanal sugerido.
- Registro de aulas.
- Conteudo visto em aula.
- Atividade, prova e prazo.
- Anexos multiplos.

### 7. Horas obrigatorias

Mostre:

- Atividades complementares.
- Estagios.
- Extensao.
- Anexos/certificados.
- Periodos continuos quando a atividade tem data inicial e final.

### 8. Estudos

Mostre:

- Materias de estudo.
- Topicos.
- Tarefas.
- Sessoes de estudo.

### 9. Backup e sync

Mostre a tela de ajustes:

- Exportacao/importacao JSON.
- Restore point antes de importacao destrutiva.
- Endpoint ativo do backend.
- Botao `Testar conexao`.
- Fila de sincronizacao.
- Botao de sincronizar.
- Backend como evolucao para multiplos dispositivos.

Explique com cuidado:

- O push da fila local para o backend ja existe.
- O pull remoto ja consulta mudancas, mas ainda nao aplica tudo automaticamente
  no banco local.
- Por isso, a sync deve ser apresentada como fundacao funcional, nao como
  multi-dispositivo final.

## Se algo falhar na hora

- Se o backend estiver offline, explique que o app continua funcionando offline.
- Se `/health` funcionar e `/ready` falhar, explique que a API esta viva, mas
  banco ou storage precisam de ajuste.
- Se o Google nao estiver configurado, use email/senha e explique que OAuth
  exige Client ID do Google Cloud.
- Se a importacao de PDF nao ler tudo corretamente, explique que PDFs academicos
  variam muito e por isso o app trabalha com preview/edicao antes de salvar.
- Se a web der erro de storage, rode no Windows para demonstrar persistencia
  local sem depender do navegador.
- Se a sync falhar, mostre que a fila local registra pendencias e use o plano B
  em `docs/PLANO_B_DEMO.md`.

## Fechamento da demo

Finalize dizendo:

> "O foco do CampusFlow e organizar a jornada academica completa. Ele ja funciona
> offline, possui persistencia local real e foi arquitetado para crescer com
> backend, sincronizacao, anexos e publicacao futura."
