<img src="assets/logo-udf.jpg" alt="UDF Centro Universitário" width="230">

**Profa. Kadidja Valéria | UDF**  
Ciência de Dados e Aprendizado de Máquina · Sistemas de Informação · 2026.2

# Aula 1 — Conceitos e classificação de problemas

## Identificação

- Estudante ou equipe: **Gustavo Carvalho de Oliveira**- Instituição e turma: **UDF – Centro Universitário · Sistemas de Informação · Turma: Sistemas de Informação
- Data de realização: **16/10/2026**
- Integrantes e contribuições: **Gustavo Carvalho de Oliveira.**

## Objetivos

Distinguir programação tradicional e Machine Learning, identificar atributos e alvo e diferenciar classificação, regressão e agrupamento.

## 1. Explicação com suas palavras

1. Como um modelo aprende com dados? **Ele parte de exemplos passados e procura uma função que ligue as entradas (atributos) à saída desejada. Durante o treino, o algoritmo testa ajustes e mede o quanto erra nos exemplos conhecidos, mudando seus parâmetros até o erro diminuir. O que fica no final é um "resumo" dos padrões dos dados. Para saber se esse resumo vale para casos novos, ele precisa ser avaliado em exemplos que não participaram do treino.**
2. Qual diferença entre algoritmo e modelo? **O algoritmo é a receita; o modelo é o prato pronto. A árvore de decisão, como método, é a mesma para qualquer conjunto de dados. Já o modelo é a árvore específica que saiu do treino com os dados do laboratório, com suas perguntas ("nota ≤ 6,21?") e folhas. Trocar os dados muda o modelo, não o algoritmo.**
3. Compare uma regra de bloqueio de palavra com um modelo de spam. **Na regra, a lógica vem da cabeça do programador: uma lista de palavras proibidas que é checada em cada mensagem. É previsível, mas qualquer variação ("gr4tis") escapa e mensagens normais com a palavra são barradas. No modelo, a lógica vem de exemplos rotulados: ele pesa muitos indícios ao mesmo tempo e atribui uma pontuação. Se adapta melhor e pode ser atualizado com novos exemplos, mas fica mais difícil explicar cada decisão e ele herda os erros dos rótulos.**
4. Dê um exemplo de atributo e alvo e defina o momento da previsão. **No help desk que uso na [atividade 07](07-aplicacao-helpdesk.md): atributo = texto escrito pelo usuário ao abrir o chamado ("impressora da sala 204 não imprime"); alvo = fila de atendimento correta ("Impressora"). A previsão acontece no instante em que o chamado é aberto, antes de qualquer técnico triá-lo; a fila correta só é confirmada depois, quando o técnico resolve o chamado. Não posso usar como atributo nada que só existe depois, como o técnico que fechou o chamado.**

## 2. Quadro comparativo

| Critério | Supervisionado | Não supervisionado |
| --- | --- | --- |
| Presença de alvo no treino | Existe uma coluna-resposta em cada exemplo do histórico. | Não existe coluna-resposta. |
| Pergunta que pode responder | "Para este caso novo, qual o resultado esperado?" | "Como estes casos se organizam? O que é parecido ou fora do comum?" |
| Tipo de saída | Uma classe (ex.: fila do chamado) ou um número (ex.: horas até resolver). | Rótulos de grupo criados pelo algoritmo, distâncias, pontuação de anomalia. |
| Tarefas e exemplo | Classificação: aprovar/negar crédito; regressão: preço de um imóvel. | Agrupamento: segmentar clientes; detecção de anomalias: picos estranhos de acesso. |
| Dados necessários | Histórico em que o desfecho foi registrado corretamente e no mesmo padrão. | Atributos que descrevam bem os casos, em escalas comparáveis. |
| Forma de avaliação | Previsões comparadas com respostas reais guardadas para teste (acurácia, F1, MAE, R²). | Coesão/separação dos grupos (ex.: silhueta) e, sobretudo, se o grupo faz sentido para quem vai usar. |
| Limitação | Rotular custa caro e o modelo repete os vieses do rótulo. | Sem gabarito, é fácil encontrar grupos que não significam nada na prática. |

## 3. Situações-problema

| Caso | Situação-problema |
| --- | --- |
| 1 Educação | Prever evadiu/permaneceu com histórico rotulado de turmas anteriores. |
| 2 Saúde | Estimar o tempo de espera em minutos a partir de registros de atendimento. |
| 3 Comércio | Descobrir perfis de compra sem categorias prévias de clientes. |
| 4 Finanças | Prever inadimplente/adimplente com contratos e desfechos conhecidos. |
| 5 Segurança digital | Distinguir spam/legítima com mensagens já revisadas. |
| 6 Comércio | Estimar o total de vendas em reais na próxima semana. |
| 7 Educação | Agrupar perfis de acesso ao ambiente virtual sem rótulo de evasão. |
| 8 Saúde | Classificar exames em categorias previamente definidas por especialistas. |

| Caso escolhido | Alvo ou ausência de alvo | Categoria, quantidade ou grupos? | Abordagem e justificativa | Dados necessários e limitação |
| --- | --- | --- | --- | --- |
| 2 Saúde | Alvo: minutos de espera | Quantidade | Supervisionado — regressão: o que se quer é um número contínuo já medido nos atendimentos passados. | Hora de chegada, dia da semana, classificação de risco, médicos de plantão, fila no momento. Limitação: o horário registrado nem sempre é o real (atrasos no cadastro) e plantões atípicos fogem do padrão. |
| 3 Comércio | Sem alvo | Grupos | Não supervisionado — agrupamento: não existe lista prévia de "tipos de cliente" para ensinar ao modelo. | Recência, frequência e valor das compras, departamentos visitados. Limitação: o número de grupos é uma escolha do analista e os resultados mudam se as escalas não forem padronizadas. |
| 4 Finanças | Alvo: inadimplente/adimplente | Categoria | Supervisionado — classificação: contratos encerrados mostram qual foi o desfecho. | Renda declarada, valor e prazo do contrato, histórico de pagamento. Limitação: só se conhece o desfecho de quem recebeu crédito (quem foi negado nunca vira exemplo), e atributos como CEP podem discriminar indiretamente. |
| 6 Comércio | Alvo: vendas em R$ | Quantidade | Supervisionado — regressão sobre uma série temporal. | Vendas das semanas anteriores, feriados, campanhas, clima. Limitação: o teste precisa estar no futuro em relação ao treino; uma crise ou concorrente novo não estava no histórico. |
| 7 Educação | Sem alvo | Grupos | Não supervisionado — agrupamento: o objetivo é descrever comportamentos, não prever evasão. | Dias e horários de acesso, tempo em vídeos, fóruns, entregas no AVA. Limitação: estar num grupo "pouco ativo" não diz por que o estudante acessa pouco (pode estudar pelo material impresso); logs são dados pessoais. |
| 8 Saúde | Alvo: categoria do laudo | Categoria | Supervisionado — classificação multiclasse com rótulos dados por especialistas. | Exames com laudo confirmado. Limitação: especialistas podem discordar entre si; exames de outro equipamento ou hospital podem ter padrão diferente; a decisão final continua sendo médica. |

## 4. Raciocínio crítico

“Detectar fraude” define sozinho o tipo de aprendizado? **Não. O nome do problema diz o objetivo, não o método. Quem decide é o dado disponível. Com um histórico de transações auditadas (fraude confirmada ou não), dá para treinar um classificador supervisionado, que reconhece bem os golpes já conhecidos, mas sofre porque fraudes são poucas no meio de milhões de operações e porque o fraudador muda de estratégia. Sem esse histórico, pode-se procurar transações que destoam do comportamento normal (detecção de anomalias), o que pega golpes novos, mas gera muitos alertas falsos — comprar uma passagem cara pela primeira vez é incomum e é legítimo. Em ambos os casos, o resultado deveria gerar uma verificação humana, não um bloqueio automático e definitivo.**

## 5. Conexão com a minha aplicação — help desk de TI

Escolhi como tema de aplicação o **suporte de TI de uma instituição** (cenário fictício): usuários abrem chamados descrevendo o problema em texto livre, e alguém precisa enviá-los para a fila certa. Três perguntas que o ML poderia responder:

| Problema no help desk | Alvo ou ausência de alvo | Categoria, quantidade ou grupos? | Abordagem e justificativa | Dados necessários e limitação |
| --- | --- | --- | --- | --- |
| Sugerir a fila de atendimento ao abrir o chamado | Alvo: fila confirmada pelo técnico | Categoria | Supervisionado — classificação multiclasse de texto. Experimento na [atividade 07](07-aplicacao-helpdesk.md). | Texto dos chamados antigos e fila final. Limitação: textos vagos ("não funciona") e chamados triados na fila errada. |
| Estimar em quantas horas o chamado será resolvido | Alvo: tempo até o fechamento (h) | Quantidade | Supervisionado — regressão. | Fila, horário de abertura, volume de chamados abertos, equipe disponível. Limitação: chamados que ficam "esperando o usuário" inflam o tempo sem relação com a dificuldade. |
| Descobrir problemas recorrentes que geram muitos chamados | Sem alvo | Grupos | Não supervisionado — agrupamento de textos semelhantes. | Textos e datas dos chamados. Limitação: um grupo de textos parecidos não prova causa comum; precisa de análise de um técnico. |

## Entrega

Salve este arquivo preenchido. Critérios: distinção conceitual, pertinência dos dados, justificativa e clareza. [Voltar ao início](README.md).
