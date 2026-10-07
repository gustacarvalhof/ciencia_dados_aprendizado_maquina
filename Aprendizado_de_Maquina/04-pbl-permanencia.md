<img src="assets/logo-udf.jpg" alt="UDF Centro Universitário" width="230">

**Profa. Kadidja Valéria | UDF**  
Ciência de Dados e Aprendizado de Máquina · Sistemas de Informação · 2026.2

# PBL integrador — Apoio à Permanência

## Identificação

- Estudante ou equipe: **Gustavo Carvalho de Oliveira (atividade individual)**
- Instituição e turma: **UDF – Centro Universitário · Sistemas de Informação · Turma: PREENCHER**
- Data de realização: **16/10/2026**
- Integrantes e contribuições (se em equipe): **Não se aplica — atividade realizada individualmente; todas as etapas são de Gustavo Carvalho de Oliveira.**

## Contexto

Uma instituição quer compreender sinais associados à evasão e oferecer apoio antes do fim do semestre. Público-alvo: estudantes matriculados e equipe de apoio acadêmico. O cenário é didático e a prática usa dados sintéticos.

**Questão norteadora:** como identificar situações que merecem atenção e oferecer apoio, reconhecendo erros do modelo e dificuldades que os dados não capturam?

## Proposta da equipe

### 1. Delimitação

- Problema e público: **A equipe de apoio acadêmico costuma agir quando o estudante já desistiu. Ela é pequena e não consegue conversar com todos nas primeiras semanas. Público: estudantes matriculados (quem recebe o apoio) e a equipe de apoio (quem usa a lista).**
- Decisão que o resultado pode apoiar: **Em que ordem a equipe faz os contatos de acolhimento na semana 5, dado que ela consegue atender um número limitado de estudantes.**
- Definição de evasão, unidade e horizonte: **Evasão = não ter frequência nem avaliação registrada nas últimas quatro semanas do semestre e não renovar a matrícula. Trancamento formal e transferência são registrados como desfechos à parte, não como evasão. Unidade: estudante-semestre. Horizonte: dados até a semana 4, desfecho no fim do semestre.**

### 2. Perguntas de negócio

1. **Ordenando os estudantes pela estimativa do modelo, quantos dos que vão evadir aparecem entre os primeiros contatados, em comparação com uma ordem simples (ex.: só pela frequência)?**
2. **Vale mais a pena para a equipe uma lista que alcança mais estudantes em evasão, mesmo com mais falsos alarmes, ou uma lista menor e mais precisa?**

### 3. Dados necessários

| Dado | Papel no projeto | Disponível quando? | Origem pretendida | Necessidade e risco |
| --- | --- | --- | --- | --- |
| Frequência até a semana 4 (%) | Atributo | Fim da semana 4 | Diário de classe | Necessário; professores que lançam a chamada com atraso geram valores falsamente baixos. |
| Nota parcial até a semana 4 | Atributo | Fim da semana 4 | Sistema acadêmico | Necessário; disciplinas sem avaliação até a semana 4 geram ausências (tratadas por imputação). |
| Entregas até a semana 4 | Atributo | Fim da semana 4 | Ambiente virtual | Útil em conjunto com os outros; depende de a disciplina usar o AVA. |
| Desfecho do semestre | Alvo | Fim do semestre | Secretaria | Obrigatório para treinar; a regra de "evasão" precisa ser a mesma em todos os semestres. |
| Código pseudônimo do estudante | Ligar as bases (fora do modelo) | Matrícula | Secretaria / TI | Necessário; a tabela que liga pseudônimo e nome fica com a TI, não com o analista. |
| Curso, turno e forma de ingresso | Não entram no modelo; usados só para auditar se o erro é parecido entre grupos | Matrícula | Secretaria | Risco de reidentificação em cursos pequenos; usar só com autorização e grupos com amostra mínima. |

Diferencie dados usados na simulação e dados que seriam necessários para uma investigação real: **A simulação tem 600 linhas geradas por uma fórmula, 3 atributos e nenhuma noção de tempo ou de grupo. Uma investigação real precisaria de vários semestres (para treinar no passado e testar no futuro), a mesma definição de evasão aplicada a todos, informações de grupo para auditoria, o registro de quais estudantes já receberam apoio (para não confundir o efeito do apoio com o do modelo) e escuta dos estudantes sobre as razões de saída, tudo com aprovação ética e base legal na LGPD.**

### 4. Abordagem e algoritmo

- Classificação, regressão ou outra formulação, com justificativa: **Classificação binária supervisionada: o histórico diz quem evadiu ou não. Na prática, uso a estimativa de probabilidade da árvore para ordenar a lista, mas o alvo continua sendo uma classe.**
- Algoritmo introdutório escolhido: **Árvore de decisão com `max_depth=5` e `min_samples_leaf=40` (escolhidos juntos por validação cruzada), precedida de imputação pela mediana. As folhas grandes deixam poucas regras, fáceis de mostrar à equipe ("nota abaixo de 6,2 e frequência abaixo de 65%").**
- Referência simples: **`DummyClassifier` com a classe mais frequente (ninguém evade).**

### 5. Avaliação

- Preparação, divisão e validação: **Divisão estratificada 75/25 (450 treino, 150 teste), semente 42; mediana aprendida só no treino; grade de 16 combinações profundidade × folha avaliada por validação cruzada de 5 dobras, com regra de desempate definida antes; teste usado uma vez. Em dados reais, o teste seria o semestre mais recente.**
- Métricas e razão da escolha: **Sensibilidade (quantos evadidos a lista alcança) como métrica principal, precisão (quantos da lista realmente precisavam) como segunda, e acurácia e matriz para visão geral, sempre ao lado da referência.**
- Resultados efetivamente calculados e link da evidência: **Validação 0,729 ± 0,030; teste 0,780 (referência 0,593); TN = 70, FP = 19, FN = 14, TP = 47; sensibilidade 0,770; precisão 0,712. Evidências: [notebook](notebooks/laboratorio-equipe.ipynb), [registro do laboratório](03-aula2-laboratorio.md), [matriz](assets/matriz-confusao.png).**
- Erros relevantes e consequências: **14 estudantes em evasão (23%) ficariam fora da lista; 19 dos 66 sinalizados (29%) não precisavam. No experimento com `class_weight='balanced'` (só validação), a sensibilidade subiu de 0,61 para 0,69 com precisão caindo de 0,70 para 0,64 — é a escolha da pergunta 2, que depende da capacidade da equipe e teria que ser confirmada em novo teste.**

### 6. Limites e proteção

- Por que os resultados não demonstram causalidade? **Porque só observamos que certas combinações de nota e frequência aparecem junto com a evasão. Não alteramos nada e comparamos o resultado. Um estudante pode faltar e evadir pelo mesmo motivo de fundo (mudança de emprego, cuidar de um familiar). Aqui, ainda por cima, a relação foi escrita na fórmula da simulação.**
- Por que dados sintéticos não validam uso institucional? **Porque o modelo só aprendeu a fórmula que gerou os dados. Ele não viu registros incompletos, professores que lançam notas tarde, mudanças de currículo nem a diversidade de estudantes reais; um bom resultado aqui não diz nada sobre o desempenho na instituição.**
- Que grupos podem ser mal representados? Como investigar isso com evidências apropriadas? **Estudantes do noturno que trabalham (podem ter frequência mais baixa sem intenção de sair), ingressantes por transferência (notas iniciais em outro padrão), estudantes com deficiência que usam atividades adaptadas fora do AVA, e cursos pequenos. A investigação seria calcular sensibilidade e taxa de falsos positivos separadamente por grupo em dados reais autorizados, apenas onde houver casos suficientes, e ouvir representantes desses grupos sobre os resultados.**
- Como minimizar dados, restringir acesso e definir retenção? **Só os três atributos e o desfecho entram no modelo; o analista trabalha com pseudônimos; a lista com nomes é gerada apenas para a equipe de apoio, com registro de acesso; professores não veem a lista; listas nominais são apagadas ao fim do semestre, ficando só contagens agregadas para reavaliar o modelo; tudo documentado conforme a LGPD.**
- Como garantir revisão humana e contestação? **Um membro da equipe revisa cada nome antes do contato e pode retirar alguém da lista (por exemplo, se já está sendo acompanhado). O estudante pode recusar o contato, saber que dados foram usados e pedir correção. Nenhuma nota, bolsa ou matrícula é afetada pelo modelo, e o desempenho é revisado a cada semestre.**

### 7. Recomendações de apoio

- Ação voluntária proposta: **Mensagem curta da coordenação convidando para uma conversa de 15 minutos sobre "como está o semestre", com opção de horário noturno e on-line, e oferta de monitoria, plano de estudos e informação sobre auxílios — sem qualquer menção à previsão do modelo.**
- Como acolher estudantes não sinalizados pelo modelo: **Os mesmos serviços divulgados para todas as turmas na semana 4, um formulário de autoencaminhamento e um canal para professores indicarem estudantes, porque o modelo deixa de fora cerca de 1 em cada 4 casos.**
- O que precisa ser verificado antes de aplicação real: **Teste com semestres futuros; auditoria de erro por grupo; parecer ético e jurídico; definição oficial de evasão; número de contatos que a equipe consegue fazer; piloto em poucos cursos, comparando com cursos sem a lista, para saber se o apoio realmente ajuda.**

Previsões não são certezas. Priorize apoio e revisão humana, sem punições ou decisões automáticas prejudiciais.

## Apresentação de cinco minutos

| Tempo | Conteúdo | Responsável |
| --- | --- | --- |
| 1 minuto | Problema e dados | Gustavo |
| 2 minutos | Método e resultados | Gustavo |
| 1 minuto | Limitações | Gustavo |
| 1 minuto | Recomendações de apoio | Gustavo |

## Contribuições

| Integrante | Contribuição verificável |
| --- | --- |
| Gustavo Carvalho de Oliveira | Atividade individual: todas as seções, execução do [notebook](notebooks/laboratorio-equipe.ipynb) e experimentos registrados na [atividade 03](03-aula2-laboratorio.md). |

[Voltar ao início](README.md).
