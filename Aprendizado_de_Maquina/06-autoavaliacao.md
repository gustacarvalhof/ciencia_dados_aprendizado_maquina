<img src="assets/logo-udf.jpg" alt="UDF Centro Universitário" width="230">

**Profa. Kadidja Valéria | UDF**  
Ciência de Dados e Aprendizado de Máquina · Sistemas de Informação · 2026.2

# Autoavaliação e conferência da entrega

## Identificação

- Estudante ou equipe: **Gustavo Carvalho de Oliveira**
- Instituição e turma: **UDF – Centro Universitário · Sistemas de Informação · Turma: Sistemas de Informação**
- Data de realização: **16/10/2026**
- Integrantes e contribuições (se em equipe): **Gustavo Carvalho de Oliveira.**

## Checklist

- [x] Diferenciei IA, Ciência de Dados e ML com um exemplo.
- [x] Completei o quadro supervisionado/não supervisionado.
- [x] Justifiquei pelo menos cinco situações-problema.
- [x] Registrei a investigação da biblioteca.
- [x] Identifiquei atributos, alvo, unidade e momento da previsão.
- [x] Executei e documentei a prática em Python ou Orange.
- [x] Escolhi configurações usando treino/validação.
- [x] Mantive o teste fora do ajuste e da seleção.
- [x] Interpretei acurácia, matriz, MAE e R².
- [x] Comparei com uma referência e discuti erros.
- [x] Registrei limitações, dados sintéticos, privacidade e vieses.
- [x] Formulei recomendações de apoio com revisão humana.
- [x] Respondi às questões individuais.
- [ ] Conferi os links e os arquivos de evidências. *(marcar depois de subir no GitHub e abrir cada link)*
- [ ] Substituí os campos PREENCHER ou justifiquei os não aplicáveis. *(falta: turma e link do repositório)*

## Reflexão individual

- O que aprendi e consigo explicar: **Que a ordem das etapas importa tanto quanto o algoritmo: dividir os dados, aprender a preparação só no treino, escolher configurações por validação e abrir o teste uma vez. Consigo explicar por que coloquei `min_samples_leaf` na grade antes do teste e como isso mudou o modelo final. Também consigo ler uma matriz de confusão, calcular acurácia, sensibilidade e precisão e explicar MAE e R² sem confundir R² com "porcentagem de acerto".**
- Qual foi minha principal dificuldade: **Entender por que duas árvores com a mesma acurácia de teste (0,78) podem ser escolhas bem diferentes — a minha erra menos falsos negativos e mais falsos positivos — e decidir qual métrica priorizar conforme o problema.**
- Qual evidência mostra meu avanço: **A grade de 16 combinações com regra de desempate definida antes do teste e os cálculos manuais (117/150 = 0,78; 47/61 ≈ 0,770) no [registro do laboratório](03-aula2-laboratorio.md); o experimento próprio de help desk na [atividade 07](07-aplicacao-helpdesk.md), em que também escolhi o limiar de confiança sem usar o teste.**
- Como contribuímos com a equipe: **Não se aplica — atividade individual. Realizei todas as etapas.**
- O que preciso revisar: **Validação com divisão temporal; como escolher um limiar de decisão a partir do custo de cada erro; métricas de agrupamento (silhueta).**
- Ferramentas de apoio utilizadas, incluindo IA quando houver, e como verifiquei as respostas: **Jupyter com scikit-learn 1.9.1; assistente de IA (Claude) para apoio na escrita do código e do texto. Verifiquei executando os notebooks (semente 42), refazendo os cálculos da matriz e do MAE à mão e conferindo que os dados gerados são iguais ao CSV fornecido.**

## Critérios de avaliação

Escala sugerida do material: nível 3 consistente, 2 adequado com lacunas, 1 parcial, 0 ausente/incoerente. Nota do critério = peso × nível/3. A professora pode ajustar a aplicação.

| Critério | Peso aula 1 | Peso aula 2/PBL |
| --- | --- | --- |
| Problema e conceitos | 3,0 | 2,0 |
| Dados e justificativa | 2,0 | 2,0 |
| Método e avaliação | 1,0 | 3,0 |
| Interpretação e responsabilidade | 2,0 | 2,0 |
| Clareza e colaboração | 2,0 | 1,0 |
| Total | 10,0 | 10,0 |

Na aula 1, método corresponde à avaliação proposta. Na aula 2, inclui execução e interpretação. A maior acurácia isolada não assegura a melhor avaliação da atividade.

## Fontes de apoio

- SCIKIT-LEARN. *User Guide*. https://scikit-learn.org/stable/user_guide.html.
- SCIKIT-LEARN. *Common pitfalls and recommended practices*. https://scikit-learn.org/stable/common_pitfalls.html.
- ORANGE DATA MINING. *Test and Score*. https://orangedatamining.com/widget-catalog/evaluate/testandscore/.

Referências indicadas no material didático do módulo, consultadas em 14 out. 2026. Registre a data da sua própria consulta quando utilizar novas fontes.

[Voltar ao início](README.md).
