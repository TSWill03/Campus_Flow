<!-- Signature: dev.tswicolly03 -->

# Guia de apresentacao do CampusFlow

Este documento foi escrito para ajudar a apresentar o CampusFlow para professor,
banca ou avaliador tecnico. A ideia e contar a historia do projeto de um jeito
claro: problema real, solucao proposta, arquitetura usada e demonstracao pratica.

## Resumo em 30 segundos

O CampusFlow e um gerenciador academico pessoal para estudantes. Ele centraliza
perfis academicos, disciplinas, aulas, anexos, horas obrigatorias, estudos,
backup e sincronizacao futura em um unico aplicativo Flutter multiplataforma.

O projeto nasceu como uma necessidade pessoal de organizar a vida academica, mas
foi estruturado como um produto evolutivo: primeiro funciona offline, depois pode
sincronizar com backend, login, multiplos dispositivos e armazenamento em nuvem.

## Problema que o projeto resolve

Estudantes costumam espalhar informacoes importantes em varios lugares:

- Matriz curricular e disciplinas em PDFs ou sites da instituicao.
- Horas complementares em certificados separados.
- Estagio e extensao em documentos diferentes.
- Aulas, atividades, provas e arquivos enviados por professores em pastas soltas.
- Planejamento de estudos em aplicativos genericos que nao entendem graduacao.

O CampusFlow junta essas informacoes em uma ferramenta focada no percurso
academico do estudante.

## Proposta de solucao

O app permite:

- Criar mais de um perfil academico, util para segunda graduacao, mestrado,
  doutorado, escola tecnica ou cursos paralelos.
- Importar grade curricular a partir de PPC/PDF e gerar disciplinas.
- Comparar disciplinas entre perfis para sugerir possiveis aproveitamentos.
- Registrar disciplinas, pre-requisitos, status, aulas, arquivos e prazos.
- Controlar horas complementares, estagio e extensao.
- Organizar estudos, tarefas, topicos e sessoes.
- Fazer backup JSON local e preparar sincronizacao com servidor.

## Como apresentar a autoria

Uma forma boa e honesta de explicar o projeto:

> "Eu comecei o CampusFlow como um projeto pessoal para organizar minha vida
> academica. Depois percebi que ele podia virar uma ferramenta maior para outros
> estudantes, entao fui estruturando a base como um produto real, com Flutter,
> banco local, backend e documentacao."

Se voce usou ferramentas de apoio durante o desenvolvimento, apresente isso como
parte do processo moderno de engenharia de software: voce definiu requisitos,
validou regras, testou fluxos, decidiu arquitetura e conduziu a evolucao do
produto.

## Decisoes tecnicas importantes

- Flutter foi escolhido para manter uma base unica para Android, iOS, Windows e
  Web.
- Drift foi escolhido porque o dominio academico tem dados relacionais:
  perfil, disciplinas, aulas, anexos, tarefas e historicos.
- Riverpod separa estado e regra de formulario da interface.
- go_router organiza as rotas e protege telas quando o usuario nao esta logado.
- Freezed/json_serializable deixam as entidades imutaveis e mais seguras.
- O app e offline-first para funcionar mesmo sem internet.
- O backend entra como evolucao, nao como dependencia obrigatoria do app.
- A fila de sync local prepara multi-dispositivo e resolucao futura de conflitos.

## O que mostrar primeiro

1. Login ou criacao de conta.
2. Dashboard vazio e criacao/importacao de perfil academico.
3. Disciplinas importadas ou cadastradas manualmente.
4. Tela de detalhes da disciplina com aulas, arquivos, atividades e provas.
5. Horas complementares, estagio e extensao.
6. Gerenciador de estudos.
7. Backup JSON e area de sincronizacao.
8. Codigo: estrutura por features, banco Drift, controller Riverpod e backend.

## Perguntas provaveis da banca

### Por que offline-first?

Porque o estudante pode precisar consultar dados sem internet, e porque dados
locais reduzem dependencia de servidor no inicio do produto. A sincronizacao vira
uma camada adicional, nao uma obrigacao para o app funcionar.

### Por que usar banco relacional local?

Porque os dados possuem relacoes claras. Uma disciplina tem aulas, anexos,
pre-requisitos e pertence a um perfil academico. Drift permite modelar isso em
SQLite com migracoes e queries eficientes.

### Como o app se prepara para sincronizacao?

Cada entidade possui metadados como `remoteId`, `syncStatus`, `createdAt`,
`updatedAt` e `isDeleted`. As alteracoes tambem entram em uma fila local de sync,
que depois pode ser enviada para o backend.

### O que diferencia esse app de uma agenda comum?

Ele entende o contexto academico: horas obrigatorias, matriz curricular,
pre-requisitos, aulas por disciplina, aproveitamento entre cursos e progresso de
graduacao.

### O que ainda falta para producao?

Mais testes automatizados, notificacoes locais, tratamento completo de conflitos
de sincronizacao, storage externo para arquivos grandes, revisao de UX,
monitoramento do backend e preparacao final para lojas.

## Frase de fechamento

O CampusFlow nao e apenas uma agenda de tarefas. Ele e uma base academica
offline-first que organiza o percurso do estudante e foi pensada para crescer
para um produto sincronizado, seguro e multiplataforma.
