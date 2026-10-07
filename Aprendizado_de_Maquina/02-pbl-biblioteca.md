<img src="assets/logo-udf.jpg" alt="UDF Centro Universitário" width="230">

**Profa. Kadidja Valéria | UDF**  
Ciência de Dados e Aprendizado de Máquina · Sistemas de Informação · 2026.2

# PBL — Biblioteca em Foco

## Identificação

- Estudante ou equipe: **Gustavo Carvalho de Oliveira (atividade individual)**
- Instituição e turma: **UDF – Centro Universitário · Sistemas de Informação · Turma: PREENCHER**
- Data de realização: **16/10/2026**
- Integrantes e contribuições (se em equipe): **Não se aplica — atividade realizada individualmente; todas as etapas são de Gustavo Carvalho de Oliveira.**

## Situação-problema

Uma biblioteca universitária enfrenta filas em horários específicos e baixa utilização de alguns serviços. A coordenação deseja melhorar o atendimento e planejar recursos. Este é um cenário didático.

**Público-alvo:** estudantes usuários, equipe de atendimento e gestão.

**Questão norteadora:** como os dados podem orientar o planejamento da biblioteca e a oferta de serviços sem identificar ou discriminar seus usuários?

## Investigação em equipe

1. Delimitem o problema e a decisão a apoiar.
2. Registrem o que já sabem e o que precisam investigar.
3. Formulem duas perguntas de negócio.
4. Definam a unidade de análise, os atributos e o alvo, quando houver.
5. Justifiquem a abordagem e indiquem se uma análise descritiva já seria suficiente.
6. Proponham avaliação, cuidados com os dados e limitações.

## Canvas da equipe

| Campo | Registro |
| --- | --- |
| Problema e decisão | O balcão e o salão de estudos ficam sobrecarregados em alguns turnos, enquanto serviços como o empréstimo de notebooks e as oficinas de pesquisa quase não são procurados. Decisões: (a) abrir ou não um segundo guichê e liberar salas extras em cada turno; (b) o que fazer com os serviços pouco usados (mudar horário, divulgar ou encerrar). |
| Público-alvo | Estudantes (menos espera e lugar para estudar), atendentes (carga de trabalho distribuída) e coordenação (uso do orçamento e do espaço). |
| O que sabemos | A lotação é percebida no fim da tarde e em semanas de prova; a catraca conta entradas e saídas; o sistema registra empréstimos, reservas de sala e de notebooks. |
| O que precisamos investigar | Se a fila é de empréstimo, de devolução ou de informação; se a baixa procura das oficinas vem do horário (coincidem com aulas?) ou da falta de divulgação; quantas pessoas desistem ao ver a fila. |
| Pergunta de negócio 1 | Em cada turno do próximo dia útil, a ocupação do salão de estudos vai passar de 80% da capacidade? (para liberar salas extras e chamar um atendente a mais com antecedência). |
| Pergunta de negócio 2 | Em quais períodos do semestre e em quais turnos cada serviço tem procura baixa, comparado ao seu próprio histórico? |
| Unidade de análise e período | P1: um turno (manhã, tarde ou noite) em um dia, nos últimos 3 semestres. P2: um serviço em uma semana. Sempre contagens agregadas, sem pessoa identificada. |
| Atributos, unidades e origem pretendida | Dia da semana, turno, semana do calendário (início, provas, recesso), ocupação média do mesmo turno na semana anterior (%), nº de entradas da catraca no turno anterior, previsão de chuva (sim/não), eventos no campus. Origem: catraca, sistema da biblioteca, calendário acadêmico. |
| Alvo e momento em que será conhecido, ou ausência de alvo | P1: alvo binário "ocupação > 80%" (sim/não), conhecido ao fim do turno; previsão feita na véspera. P2: sem alvo — é uma análise descritiva de contagens. |
| Abordagem e justificativa | P1: classificação supervisionada (o alvo é sim/não). Escolhi tratar como classificação, e não regressão, porque a decisão da coordenação é binária (abre ou não a sala extra). P2: não precisa de ML; tabelas e gráficos de procura por semana e turno respondem a pergunta. Mesmo na P1, a primeira versão deve ser uma regra simples ("repete o que aconteceu no mesmo turno da semana anterior"); o modelo só entra se for melhor que ela. |
| Alternativa sem ML | Mapa de calor de ocupação (dia × turno) atualizado semanalmente; formulário curto no balcão perguntando o que a pessoa veio fazer; enquete sobre horários preferidos para as oficinas. |
| Como avaliar a proposta | P1: dividir por tempo (treino nos semestres antigos, teste no mais recente); medir sensibilidade (turnos lotados que o modelo avisou) e precisão (avisos que eram reais), comparando com a regra "semana anterior". Depois de implantado: tempo médio de espera e reclamações por lotação. P2: verificar se a mudança de horário/divulgação aumentou a procura no semestre seguinte. |
| Privacidade e limitações | A catraca já registra matrícula; a análise deve usar só contagens por turno, descartando a matrícula antes de chegar ao analista. Não cruzar com notas ou dados socioeconômicos. Limitações: quem desiste ao ver a fila não aparece; semanas de greve ou obras distorcem o histórico; estudantes de cursos noturnos podem ter o padrão diluído no total e precisam de olhar à parte. |

## Registro de colaboração

| Integrante | Papel | Contribuição |
| --- | --- | --- |
| Gustavo Carvalho de Oliveira | Todos os papéis (atividade individual) | Delimitação do problema, perguntas de negócio, escolha de atributos e alvo, abordagem, avaliação e cuidados com privacidade. |

## Conclusão da equipe

**Proposta:** Tratar os dois problemas de forma diferente. Para a lotação, montar primeiro o mapa de calor e a regra "semana anterior"; testar um classificador que avisa na véspera se o turno passará de 80% e adotá-lo só se avisar mais turnos lotados sem gerar muitos alarmes falsos. Para os serviços pouco usados, uma análise descritiva com enquete é suficiente: não há o que prever, e sim entender por que a procura é baixa.

**Dúvida ainda aberta:** O limite de 80% é o ponto certo para decidir? A escolha deveria vir da coordenação, considerando quanto custa abrir uma sala extra sem necessidade versus deixar estudantes sem lugar.

**Feedback recebido e melhoria realizada:** Registrar após a apresentação.

## Entrega

Canvas preenchido e síntese para apresentação de dois minutos. Avaliar coerência da pergunta, dados, abordagem, responsabilidade e colaboração. [Voltar ao início](README.md).
