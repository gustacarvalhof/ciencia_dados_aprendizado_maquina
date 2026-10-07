<img src="assets/logo-udf.jpg" alt="UDF Centro Universitário" width="230">

**Profa. Kadidja Valéria | UDF**  
Ciência de Dados e Aprendizado de Máquina · Sistemas de Informação · 2026.2

# Questões de revisão — Registro individual

## Identificação

- Estudante ou equipe: **Gustavo Carvalho de Oliveira (atividade individual)**
- Instituição e turma: **UDF – Centro Universitário · Sistemas de Informação · Turma: PREENCHER**
- Data de realização: **16/10/2026**
- Integrantes e contribuições (se em equipe): **Não se aplica — atividade realizada individualmente; todas as etapas são de Gustavo Carvalho de Oliveira.**

Responda com suas palavras e apresente os cálculos quando solicitados. Os números dos exercícios manuais não são os resultados do laboratório.

## 1. Explique a diferença entre regra programada para bloquear uma palavra e modelo de spam treinado com exemplos.

**Resposta:** Na regra, eu decido o critério e o computador só o executa: "achou a palavra, bloqueia". Ela nunca muda sozinha e falha tanto para spam disfarçado quanto para e-mails legítimos que usam a palavra. No modelo, o critério é aprendido de milhares de e-mails já marcados como spam ou não; ele combina vários sinais e dá uma pontuação. Ele acompanha mudanças se for retreinado, mas suas decisões são menos transparentes e ele só é tão bom quanto os exemplos que recebeu.

## 2. Por que codificar evadiu/permaneceu como 1/0 não transforma classificação em regressão?

**Resposta:** O número é só um apelido para a categoria; poderia ser "A" e "B". A conta 1 − 0 não tem significado, e uma previsão de 0,4 "estudantes evadidos" não existe. O que define a tarefa é o tipo de resposta: duas classes → classificação, avaliada com matriz de confusão, acurácia e sensibilidade.

## 3. Uma biblioteca quer estimar empréstimos e descobrir perfis. Que tarefas correspondem a cada pergunta?

**Resposta:** Estimar empréstimos (um número) é **regressão**, supervisionada, porque o histórico tem a quantidade real de cada semana. Descobrir perfis de uso sem saber de antemão quais são é **agrupamento**, não supervisionado, porque não há rótulo de perfil para ensinar.

## 4. O que são atributo, alvo e unidade de análise no laboratório educacional?

**Resposta:** A unidade de análise é a "linha" da tabela: um estudante fictício em um semestre. Atributos são as colunas de entrada, conhecidas na semana 4 (`frequencia_sem4`, `nota_sem4`, `entregas_sem4`). O alvo é a coluna que o modelo tenta acertar, `evasao_fim_semestre` (0/1), que só fica conhecida no fim do semestre.

## 5. Por que calcular a mediana antes de dividir os dados pode invalidar a avaliação?

**Resposta:** Porque a mediana seria calculada com os 600 registros, incluindo os 150 de teste. Os dados de treino seriam preenchidos com um valor que "conhece" o teste — é um vazamento, ainda que pequeno. O teste deixa de simular dados que chegam depois e a nota final fica otimista. O correto é dividir primeiro e calcular a mediana só no treino, o que o `Pipeline` faz automaticamente.

## 6. Em uma matriz didática com TN=80, FP=5, FN=10, TP=5, calcule acurácia e sensibilidade. O resultado é suficiente para aprovar o modelo?

**Resposta:**
- Total = 80 + 5 + 10 + 5 = 100.
- Acurácia = (80 + 5) / 100 = **0,85**.
- Sensibilidade = 5 / (5 + 10) = 5 / 15 ≈ **0,333**.

Não. Existem 15 positivos e 85 negativos; prever "negativo" para todos também daria 0,85. O modelo só encontra 1 em cada 3 positivos. Antes de aprovar, eu compararia com essa referência, perguntaria quanto custa cada falso negativo no contexto e testaria em outros dados.

## 7. Valores reais 100, 120, 140 e previsões 110, 115, 130. Calcule MAE e informe a unidade se o alvo for vendas em reais.

**Resposta:** Erros absolutos: |100 − 110| = 10, |120 − 115| = 5, |140 − 130| = 10. Soma = 25.
MAE = 25 / 3 ≈ **R$ 8,33**. A unidade é a mesma do alvo: o modelo erra, em média, R$ 8,33 por previsão (sem indicar se para cima ou para baixo).

## 8. Um R² de -0,2 significa “20% de acertos negativos”? Explique.

**Resposta:** Não, porque R² não conta acertos. Ele compara o erro quadrático do modelo com o erro de prever sempre a média: R² = 1 − (erro do modelo / erro da média). Se R² = −0,2, então erro do modelo / erro da média = 1,2: o modelo erra 20% a mais que o "chute" da média. É sinal de que ele é pior do que a referência mais simples.

## 9. Uma árvore tem acurácia 1,00 no treino e 0,65 na validação. Que hipótese investigar e como?

**Resposta:** A hipótese principal é **sobreajuste**: a árvore cresceu até isolar cada exemplo e decorou o treino. Investigaria repetindo a validação cruzada com árvores mais restritas (menor `max_depth`, maior `min_samples_leaf`), como fiz na grade do laboratório, e veria se a distância treino–validação diminui. Também conferiria se há atributo que identifica o registro (um código, uma data) e se a validação supera a referência.

## 10. Por que escolher a profundidade pelo teste prejudica a estimativa final?

**Resposta:** Ao testar várias profundidades no teste e ficar com a melhor, o teste vira parte do treino: escolhi a que teve mais sorte naqueles 150 registros. O número final deixa de ser uma medida imparcial para dados novos e tende a ser otimista. Por isso a escolha é feita por validação no treino e o teste é aberto uma única vez.

## 11. Baixa frequência associada à evasão demonstra causa? Proponha explicação alternativa.

**Resposta:** Não. Uma explicação alternativa é um fator comum: o estudante muda de emprego e passa a sair tarde, o que derruba a frequência e, depois, o leva a trancar ou abandonar. Também pode ser o contrário do que parece: quem já decidiu sair para de ir às aulas, ou seja, a decisão de evadir causa a falta, e não o inverso.

## 12. Um modelo sinaliza um estudante como possível evasão. Que ação responsável pode ser adotada?

**Resposta:** A equipe de apoio revisa o caso e, se fizer sentido, envia um convite opcional para conversa, monitoria ou orientação, com linguagem acolhedora e sem citar "risco". Nada muda na situação acadêmica do estudante por causa da previsão. Ele pode recusar, saber quais dados foram usados e pedir correção, e a lista é apagada ao fim do semestre.

## Fontes adicionais consultadas

**Material da disciplina (Módulo IV); SCIKIT-LEARN. *User Guide* e *Common pitfalls and recommended practices*. Disponível em: https://scikit-learn.org/stable/. Acesso em: 16 out. 2026. Uso de IA: assistente de IA (Claude) usado para apoiar a redação e conferir cálculos; as respostas foram revisadas por mim.**

[Voltar ao início](README.md).
