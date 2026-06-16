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
- Ter um PDF/PPC pequeno ou dados de exemplo para importacao.

## Demo principal

### 1. Entrada no app

Mostre a tela de login e explique:

- Existe login com email e senha.
- A senha e protegida com hash/armazenamento seguro.
- O login com Google foi preparado para plataformas compativeis.

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
- Fila de sincronizacao.
- Botao de sincronizar.
- Backend como evolucao para multiplos dispositivos.

## Se algo falhar na hora

- Se o backend estiver offline, explique que o app continua funcionando offline.
- Se o Google nao estiver configurado, use email/senha e explique que OAuth
  exige Client ID do Google Cloud.
- Se a importacao de PDF nao ler tudo corretamente, explique que PDFs academicos
  variam muito e por isso o app trabalha com preview/edicao antes de salvar.
- Se a web der erro de storage, rode no Windows para demonstrar persistencia
  local sem depender do navegador.

## Fechamento da demo

Finalize dizendo:

> "O foco do CampusFlow e organizar a jornada academica completa. Ele ja funciona
> offline, possui persistencia local real e foi arquitetado para crescer com
> backend, sincronizacao, anexos e publicacao futura."
