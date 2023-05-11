# Cancer Classification in R

Neste projeto realizei uma classificação de células cancerígenas, categorizadas como `B` : Beniginas ou `M`: Malignas.
Utilizando a biblioteca `ctree`, realizei a classificação plotando uma Árvore de Decisão com o R.

## Tratamento dos Dados

Para esse problema em específico, tinhamos dois problemas iniciais que precisavam ser eliminados para que o modelo pudesse ser gerado.
1. Tinhamos duas colunas que eram indesejadas, a coluna `id` e a coluna `X`. Para retirá-las eu utilizei o comando: `cancer <- cancer[ c(2:32) ]`. Onde c(2,32) seleciona a faixa das colunas que eu quero trabalhar.           
2. O R não conseguia entender o que seria uma variável do tipo `chr`. Então, foi necessária transformá-la em uma variável do tipo `Factor`com o comando `cancer$diagnosis <- as.factor(cancer$diagnosis)`. Onde atualiza o tipo da coluna diagnosis por meio do comando `as.factor` selecionando apenas a coluna diagnosis. O restante das variáveis eram do tipo numéricas, não sendo necessárias nenhum tipo de mudança.

                  `
                      'data.frame':	569 obs. of  33 variables:
                        $ diagnosis              : chr  "M" "M" "M" "M" ...
                  `

## Dados de Treino e Teste

Com a geração da amostra, dividimos o `data.frame` em dados de treino e dados de teste. Com a amostra gerada anterioremente. Utilizamos uma semente para que pudesse haver reprodutibilidade do modelo.

                  `
                      set.seed(1234)
                      ind <- sample(2, nrow(cancer), replace=TRUE, prob=c(0.8,0.2))

                      # TRAIN AND TEST DATA
                       train.data <- cancer[ind==1,]
                       test.data <- cancer[ind==2,]
                  `
                  
                 
## Geração do modelo

O modelo em R, precisa que escolhamos as variáveis dependentes e independentes. Como queríamos classificar as células em benignas e em malignas, a nossa coluna diagnosis que contem os valores `B`|`M` seria utilizada como variável dependente. E as outras colunas como independentes. `myFormula <- diagnosis ~ .`


`
                    cancer_ctree <- ctree(myFormula, scores = c("B", "M"), data=train.data)
                    print(cancer_ctree)
                    table(predict(cancer_ctree),train.data$diagnosis)
`

Temos então a geração do modelo descrito pelo `ctree` 
<br />
![image](https://github.com/cantaruttim/Cancer_R/assets/81988636/bef84a9d-89e8-4485-905d-a896bbc8f699)

<br />

E podemos visualizar a `Árvore de Decisão` com o comando `plot`
<br />
![image](https://github.com/cantaruttim/Cancer_R/assets/81988636/06c3c201-38e2-4aa0-88f0-0008bfd2d7ab)


## Acurácia
Considerando os valores da matriz de confusão gerada pelo comando `table`, logo após a geração do modelo, tivemos uma acurácia de 95.8%
