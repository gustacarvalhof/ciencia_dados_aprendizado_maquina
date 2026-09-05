# Template - Definição do Projeto de Ciência de Dados

**Unidade:** III - Gestão de Projetos  
**Metodologia:** PBL + trabalho em equipes  
**Entregável:** Documento de definição do projeto

## 1. Identificação do projeto

| Campo | Preenchimento |
|---|---|
| Título provisório do projeto | Classificação Automática de Arquivos Seguros e Potencialmente Maliciosos com Aprendizagem de Máquina |
| Curso / disciplina | Sistemas de Informação |
| Turma | Ciência de Dados e Aprendizagem de Máquina |
| Equipe | Equipe Layse Steffany e Gustavo Carvalho |
| Integrantes e funções iniciais | Layse Steffany: coordenação, preparação dos dados e modelagem. Gustavo Carvalho: análise exploratória, desenvolvimento, validação dos modelos e documentação. |
| Professor(a) | Kadidja |
| Data de elaboração | 16/09/2026 |
| Versão do documento | 1.0 |

## 2. Visão geral

### 2.1 Resumo do projeto

Usuários recebem diariamente arquivos por e-mail e downloads, mas nem sempre conseguem identificar se são seguros. Arquivos maliciosos podem infectar dispositivos, comprometer informações e causar prejuízos. O projeto propõe analisar características estáticas dos arquivos, como tamanho, cabeçalhos, seções, strings e entropia, utilizando técnicas de aprendizagem de máquina para classificá-los como seguros ou potencialmente maliciosos. Espera-se desenvolver e avaliar modelos capazes de apoiar a identificação automatizada de arquivos suspeitos, contribuindo para uma triagem mais rápida e eficiente.

### 2.2 Declaração do projeto em uma frase

**Versão da equipe:**

Nosso projeto utilizará conjuntos públicos de dados, especialmente o EMBER, para identificar e classificar arquivos potencialmente maliciosos a partir de suas características estáticas, apoiando usuários e equipes de TI na decisão de liberar, bloquear ou encaminhar arquivos para análise de segurança.

## 3. Contexto e definição do problema

### 3.1 Contexto

O problema ocorre principalmente no recebimento de arquivos por e-mail e em downloads realizados em computadores e dispositivos conectados à internet.

Usuários comuns, estudantes, profissionais e equipes de TI de pequenas e médias organizações são afetados pela dificuldade de identificar arquivos potencialmente perigosos.

Entre os principais sinais que demonstram a relevância do problema estão os relatórios de segurança que apontam o e-mail como um dos meios utilizados para distribuição de malware, além do crescimento constante de novas ameaças digitais.

A investigação é importante porque métodos tradicionais de detecção, baseados exclusivamente em assinaturas conhecidas, podem apresentar limitações diante de novas variantes de malware. Nesse contexto, a aprendizagem de máquina pode identificar padrões e características que auxiliem na classificação automatizada de arquivos.

### 3.2 Problema central

Usuários de e-mail e de dispositivos conectados enfrentam dificuldades para distinguir arquivos seguros de potencialmente maliciosos durante o recebimento e download de arquivos, aumentando o risco de infecções por malware, perda de dados, vazamento de informações e comprometimento dos dispositivos.

### 3.3 Evidências iniciais

| Evidência | Fonte | O que ela indica? | Confiabilidade / limitação |
|---|---|---|---|
| 1. Relatórios de segurança identificam o e-mail como um vetor recorrente de ataques digitais. | Verizon – Data Breach Investigations Report (DBIR). | Demonstra a relevância dos riscos associados ao recebimento de arquivos. | Alta, mas depende dos incidentes reportados. |
| 2. O volume de novas amostras de malware cresce continuamente. | AV-TEST Institute – Malware Statistics. | Demonstra a dificuldade de realizar análises exclusivamente manuais. | Alta, mas os números variam conforme o período. |
| 3. Pesquisas demonstram a possibilidade de identificar arquivos maliciosos utilizando características estáticas e aprendizagem de máquina. | Anderson e Roth (2018) – EMBER Dataset. | Fundamenta a viabilidade técnica da proposta. | Média a alta, considerando as limitações temporais e os tipos de arquivos estudados. |

## 4. Público-alvo e partes interessadas

### 4.1 Público-alvo principal

| Aspecto | Descrição |
|---|---|
| Quem são os usuários ou beneficiários? | Usuários de e-mail, profissionais, estudantes e equipes de TI de pequenas e médias organizações. |
| Quais necessidades possuem? | Identificar arquivos suspeitos antes de abri-los, utilizando ferramentas que não exijam conhecimento avançado em segurança digital. |
| Como são afetados pelo problema? | Podem sofrer infecções por malware, perda de informações, vazamento de dados e comprometimento de dispositivos. |
| Que decisão ou ação poderão tomar com os resultados? | Decidir se um arquivo pode ser liberado, bloqueado ou encaminhado para uma análise mais aprofundada. |

### 4.2 Partes interessadas

| Parte interessada | Interesse no projeto | Influência | Forma de envolvimento |
|---|---|---|---|
| Professora Kadidja | Avaliar a qualidade técnica e metodológica do projeto. | Alta | Orientação e avaliação das entregas. |
| Layse Steffany e Gustavo Carvalho | Desenvolver modelos eficientes e documentar os resultados. | Alta | Participação em todas as etapas. |
| Usuários finais | Obter maior segurança no recebimento de arquivos. | Média | Beneficiários dos resultados. |
| Equipes de TI e segurança | Utilizar os resultados como apoio à triagem de arquivos. | Média | Avaliação da utilidade dos indicadores. |

## 5. Objetivos do projeto

### 5.1 Objetivo geral

Desenvolver e avaliar modelos de aprendizagem de máquina capazes de classificar arquivos como seguros ou potencialmente maliciosos, utilizando características estáticas extraídas de conjuntos públicos de dados, com a finalidade de apoiar a identificação automatizada de ameaças digitais.

### 5.2 Objetivos específicos

| Nº | Objetivo específico | Evidência de conclusão |
|---:|---|---|
| 1 | Obter e documentar conjuntos públicos de dados contendo arquivos benignos e maliciosos. | Documentação da origem, volume e características dos dados. |
| 2 | Realizar a limpeza, preparação e transformação dos dados. | Base tratada e notebook reproduzível. |
| 3 | Realizar análise exploratória para identificar padrões e diferenças entre as classes. | Gráficos e tabelas com pelo menos cinco variáveis analisadas. |
| 4 | Treinar e comparar pelo menos três algoritmos de classificação. | Comparação entre regressão logística, Random Forest e gradiente boosting. |
| 5 | Avaliar o desempenho dos modelos e documentar os resultados. | Relatório com métricas, matriz de confusão e análise de erros. |

### 5.3 Verificação dos objetivos

- [x] São específicos e escritos com clareza.
- [x] Podem ser verificados por meio de entregáveis ou métricas.
- [x] São viáveis com os dados, recursos e tempo disponíveis.
- [x] Estão diretamente relacionados ao problema central.
- [x] Consideram os usuários e a decisão que será apoiada.

## 6. Perguntas de negócio

| Nº | Pergunta de negócio | Decisão apoiada | Dados necessários | Análise ou indicador possível |
|---:|---|---|---|---|
| 1 | Quais características mais diferenciam arquivos seguros de arquivos maliciosos? | Identificar os principais indicadores de risco. | Cabeçalhos, seções, strings e entropia. | Importância das variáveis e comparação estatística. |
| 2 | Qual modelo apresenta melhor desempenho na classificação dos arquivos? | Escolher o algoritmo mais adequado. | Base rotulada de arquivos benignos e maliciosos. | Acurácia, precisão, recall, F1 e AUC-ROC. |
| 3 | Qual é a frequência de arquivos seguros classificados incorretamente como maliciosos e vice-versa? | Definir critérios de liberação e bloqueio. | Resultados das previsões e rótulos reais. | Matriz de confusão e taxas de erros. |
| 4 | O desempenho do modelo muda quando são analisados arquivos de períodos diferentes? | Identificar a necessidade de atualização do modelo. | Dados com informações temporais. | Comparação de métricas entre períodos. |
| 5 | Quais características estão presentes nos arquivos que o modelo classifica incorretamente? | Identificar situações que exigem análise humana. | Registros de previsões incorretas e características dos arquivos. | Análise de falsos positivos e falsos negativos. |

## 7. Hipóteses iniciais

| Hipótese | Como poderá ser testada? | Resultado que a refutaria? |
|---|---|---|
| H1. Arquivos maliciosos apresentam, em média, maior entropia que arquivos seguros. | Comparação estatística da entropia entre as classes. | Ausência de diferença significativa ou entropia menor nos arquivos maliciosos. |
| H2. Algoritmos baseados em árvores apresentam desempenho superior à regressão logística. | Treinamento e comparação dos modelos utilizando as mesmas divisões de dados. | Regressão logística apresentar resultados iguais ou superiores. |
| H3. O desempenho dos modelos diminui quando são utilizados arquivos mais recentes que os dados de treinamento. | Treinar com dados antigos e testar com dados de períodos posteriores. | Desempenho permanecer estável entre os períodos analisados. |

## 8. Dados necessários e viabilidade

| Conjunto ou fonte de dados | Variáveis principais | Formato | Acesso / responsável | Qualidade esperada |
|---|---|---|---|---|
| EMBER Dataset | Rótulos, cabeçalhos, seções, importações, strings, entropia e histograma de bytes. | JSON e vetores de características. | Público / Layse Steffany e Gustavo Carvalho. | Alta, com documentação e amostras rotuladas. |
| MalwareBazaar (abuse.ch) | Hash, família de malware, tipo de arquivo e data de envio. | CSV e JSON. | Público / Layse Steffany e Gustavo Carvalho. | Média, dependendo da qualidade dos registros. |
| Base complementar de arquivos benignos | Tipo, tamanho, hash e características estáticas. | CSV. | A definir pela equipe. | Média, dependendo da fonte utilizada. |

### 8.1 Avaliação inicial dos dados

- **Disponibilidade:** o EMBER Dataset e os metadados do MalwareBazaar possuem acesso público, permitindo sua utilização para fins acadêmicos, respeitando os respectivos termos de uso.
- **Volume e período coberto:** o EMBER possui aproximadamente um milhão de amostras, provenientes principalmente de executáveis Windows coletados entre 2017 e 2018.
- **Dados ausentes, duplicados ou inconsistentes previstos:** amostras sem classificação, valores ausentes, duplicidades e possível desequilíbrio entre as classes.
- **Necessidade de integração entre fontes:** inicialmente baixa, pois o EMBER será utilizado como principal fonte de dados.
- **Restrições legais, contratuais ou institucionais:** respeitar as licenças, os termos de utilização e as recomendações de segurança das bases públicas.

### 8.2 Privacidade, ética e segurança

- [x] A equipe verificou se há dados pessoais ou sensíveis.
- [x] A coleta e o uso dos dados possuem finalidade legítima e explícita.
- [x] O acesso será limitado às pessoas autorizadas.
- [x] Dados pessoais serão minimizados, anonimizados ou pseudonimizados quando necessário.
- [x] Possíveis vieses e impactos sobre grupos serão analisados.
- [x] A divulgação dos resultados evitará reidentificação ou exposição indevida.

**Cuidados específicos deste projeto:**

A equipe utilizará preferencialmente características estáticas previamente extraídas dos arquivos, evitando executar amostras maliciosas. Caso seja necessário realizar testes com arquivos reais, estes deverão ocorrer em ambiente virtual isolado e sem conexão com a rede. Também serão considerados os riscos de falsos positivos e falsos negativos, deixando claro que o modelo servirá como ferramenta de apoio à decisão, e não como substituto de soluções profissionais de segurança.

## 9. Escopo do projeto

| Dentro do escopo | Fora do escopo |
|---|---|
| Classificação binária de arquivos seguros e potencialmente maliciosos. | Análise dinâmica por execução em sandbox. |
| Utilização de conjuntos públicos de arquivos rotulados, principalmente executáveis PE. | Identificação detalhada de famílias de malware. |
| Treinamento e comparação de pelo menos três algoritmos de aprendizagem de máquina. | Integração com antivírus ou clientes de e-mail em produção. |
| Análise exploratória, avaliação de erros e comparação de desempenho. | Desenvolvimento de uma solução comercial de segurança. |
| Elaboração de relatório e apresentação dos resultados. | Análise do conteúdo de mensagens, links e remetentes de e-mail. |

**Restrições conhecidas:**

O projeto está condicionado ao prazo estabelecido pela disciplina, à disponibilidade de infraestrutura computacional e ao conhecimento técnico da equipe. Serão utilizadas ferramentas gratuitas, como Python, Jupyter Notebook e bibliotecas de aprendizagem de máquina. A base principal possui limitações temporais e contempla principalmente executáveis Windows, restringindo a generalização dos resultados para outros formatos de arquivos.

## 10. Resultados e entregáveis previstos

| Entregável | Descrição | Formato | Responsável | Critério de aceite |
|---|---|---|---|---|
| Base tratada | Dados limpos, organizados e divididos em treino, validação e teste. | CSV ou Parquet. | Layse Steffany e Gustavo Carvalho. | Base documentada e sem inconsistências impeditivas. |
| Análise exploratória | Identificação de padrões e diferenças entre arquivos seguros e maliciosos. | Notebook Jupyter. | Gustavo Carvalho. | Pelo menos cinco variáveis analisadas. |
| Visualizações / painel | Gráficos de distribuição, importância das variáveis, curva ROC e matriz de confusão. | Imagens ou painel interativo. | Gustavo Carvalho. | Visualizações legíveis e devidamente identificadas. |
| Relatório ou apresentação | Documentação do problema, metodologia, resultados e limitações. | PDF e slides. | Layse Steffany e Gustavo Carvalho. | Todos os objetivos e perguntas de negócio contemplados. |
| Outro | Código-fonte e instruções para reprodução do projeto. | Repositório GitHub. | Layse Steffany e Gustavo Carvalho. | Código organizado e instruções de execução disponíveis. |

## 11. Critérios de sucesso

| Critério | Indicador ou evidência | Meta | Forma de verificação |
|---|---|---|---|
| Relevância para o problema | Respostas às perguntas de negócio. | 5 perguntas respondidas. | Avaliação do relatório. |
| Qualidade dos dados | Duplicidades e valores inválidos. | Nenhuma duplicidade ou inconsistência impeditiva na base final. | Verificação no notebook. |
| Qualidade da análise | F1 e AUC-ROC. | F1 ≥ 0,90 e AUC-ROC ≥ 0,95 como metas iniciais. | Avaliação em conjunto de teste independente. |
| Utilidade para o público-alvo | Taxas de falsos positivos e falsos negativos. | Falsos positivos abaixo de 5% e falsos negativos abaixo de 10%, como metas iniciais. | Matriz de confusão. |
| Comunicação dos resultados | Qualidade do relatório e reprodutibilidade. | Relatório completo e código executável. | Avaliação da professora. |

*As metas numéricas serão consideradas objetivos experimentais, não garantias de desempenho. Poderão ser revistas após a análise exploratória.*

## 12. Plano inicial de trabalho

| Etapa | Atividades principais | Responsável(is) | Prazo | Dependências |
|---|---|---|---|---|
| 1. Definição | Delimitação do problema, objetivos, perguntas e escopo. | Layse Steffany e Gustavo Carvalho. | Semana 1 | Nenhuma. |
| 2. Obtenção dos dados | Download e documentação do EMBER Dataset. | Layse Steffany. | Semana 2 | Etapa 1. |
| 3. Preparação dos dados | Limpeza, remoção de duplicidades e preparação das variáveis. | Layse Steffany e Gustavo Carvalho. | Semanas 3 e 4 | Etapa 2. |
| 4. Análise / modelagem | Análise exploratória e treinamento dos três algoritmos. | Layse Steffany e Gustavo Carvalho. | Semanas 5 a 7 | Etapa 3. |
| 5. Validação | Avaliação das métricas, análise dos erros e teste das hipóteses. | Gustavo Carvalho e Layse Steffany. | Semana 8 | Etapa 4. |
| 6. Comunicação | Elaboração do relatório, apresentação e organização do código. | Layse Steffany e Gustavo Carvalho. | Semanas 9 e 10 | Etapa 5. |

## 13. Riscos do projeto

| Risco | Probabilidade | Impacto | Estratégia de resposta | Responsável |
|---|---|---|---|---|
| Base de dados antiga ou limitada a um tipo de arquivo. | Alta | Médio | Documentar as limitações e avaliar o desempenho por período. | Layse Steffany. |
| Desequilíbrio entre classes ou rótulos incorretos. | Média | Alto | Utilizar métricas complementares e técnicas de balanceamento, quando necessário. | Gustavo Carvalho. |
| Atrasos no cronograma e sobrecarga da equipe. | Média | Alto | Priorizar as atividades essenciais e acompanhar os prazos semanalmente. | Layse Steffany e Gustavo Carvalho. |
| Manuseio inadequado de arquivos maliciosos. | Baixa | Alto | Utilizar características previamente extraídas e ambientes isolados para eventuais testes. | Gustavo Carvalho. |

## 14. Organização da equipe

| Integrante | Papel principal | Responsabilidades | Apoio necessário |
|---|---|---|---|
| Layse Steffany | Coordenação e ciência de dados | Planejamento, obtenção dos dados, preparação da base e modelagem. | Orientação da professora Kadidja. |
| Gustavo Carvalho | Análise e desenvolvimento | Análise exploratória, desenvolvimento, validação dos modelos, visualizações e documentação técnica. | Apoio na implementação e interpretação dos resultados. |

## 15. Validação da definição do projeto

- [x] O problema é real, relevante e delimitado.
- [x] O público-alvo e as partes interessadas estão identificados.
- [x] O objetivo geral e os objetivos específicos são coerentes.
- [x] As perguntas de negócio orientam decisões concretas.
- [x] Há dados potencialmente disponíveis para responder às perguntas.
- [x] O escopo é compatível com o prazo e os recursos.
- [x] Os critérios de sucesso são mensuráveis.
- [x] Riscos, privacidade, ética e segurança foram considerados.
- [x] Funções e responsabilidades foram distribuídas.

## 16. Aprovação e registro de ajustes

| Responsável | Validação / observação | Data |
|---|---|---|
| Representantes da equipe: Layse Steffany e Gustavo Carvalho | Definição elaborada e revisada pela equipe. | 16/09/2026 |
| Professora / orientadora: Kadidja | Aguardando validação. | |

### Ajustes solicitados após a apresentação inicial

Nenhum ajuste registrado até o momento.
