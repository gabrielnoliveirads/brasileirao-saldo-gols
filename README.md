# ⚽ Análise do Saldo de Gols no Rebaixamento do Brasileirão

Este projeto investiga a capacidade preditiva do **saldo de gols acumulado** ao longo do campeonato em comparação com a **tabela oficial por pontos**, avaliando qual indicador antecipa com maior precisão quais clubes serão rebaixados para a Série B no Campeonato Brasileiro (era dos pontos corridos com 20 clubes: 2006–2024).

---

## 💡 Hipótese Principal

O saldo de gols expõe a fragilidade estrutural das equipes antes da tabela de pontos. Times com saldo acentuadamente negativo tendem à *regressão à média* nas rodadas finais (ex: 25ª rodada), tornando o saldo de gols um indicador de risco de rebaixamento mais preciso do que a pontuação momentânea.

---

## 📂 Estrutura do Repositório

```text
.
├── data/                       # Base de dados (campeonato-brasileiro-full.csv)
├── scripts/                    # Pipeline em R dividido em etapas modulares
│   ├── 01-importacao.R         # Leitura e carregamento dos dados brutos
│   ├── 02-limpeza.R            # Tratamento, filtros (2006+) e criação de variáveis
│   ├── 03-analise.R            # Mapeamento do Z4 por Pontos vs. Saldo nas rodadas
│   └── 04-resultado.R          # Matrizes de confusão e métricas de acurácia global
├── Projeto_brasileirao.Rproj   # Arquivo de projeto do RStudio
└── README.md                   # Documentação do projeto
```

---

## 🛠️ Tecnologias e Pacotes

- **Linguagem:** R
- **Ambiente:** RStudio
- **Pacotes Principais:** `tidyverse` e `lubridate`

---

## 🚀 Como Executar o Projeto

Como o projeto foi estruturado de forma modular na pasta `scripts/`, siga a ordem numérica de execução:

1. **Clone o repositório:**
   ```bash
   git clone [https://github.com/gabrielnoliveirads/brasileirao-saldo-gols.git](https://github.com/gabrielnoliveirads/brasileirao-saldo-gols.git)
   ```
2. Abra o arquivo **`Projeto_brasileirao.Rproj`** no RStudio para definir automaticamente o diretório de trabalho.
3. Garanta que possui os pacotes necessários instalados:
   ```R
   install.packages(c("tidyverse", "lubridate"))
   ```
4. Execute os scripts em sequência no R:
   * **`scripts/01-importacao.R`**: Carrega a base local de jogos.
   * **`scripts/02-limpeza.R`**: Filtra partidas a partir de 2006 e estrutura os dados por time/rodada.
   * **`scripts/03-analise.R`**: Calcula a classificação por pontos e saldo na rodada desejada (ex: Rodada 25) e cruza com os rebaixados finais (Rodada 38).
   * **`scripts/04-resultado.R`**: Gera as Matrizes de Confusão, Sensibilidade, Especificidade e Acurácia Global.

---

## 📊 Principais Descobertas

- **Acurácia na 25ª Rodada:** O saldo de gols acumulado na 25ª rodada mostrou-se um preditor de queda extremamente eficiente, identificando times com pontuação "inflada" por vitórias magras, mas com desempenho defensivo/ofensivo fragilizado.
- **Métricas Globais:** Ambos os indicadores apresentam Acurácia Global superior a 90% na reta final, com o saldo de gols se destacando em rodadas mais precoces.

---

*Fonte dos dados:* Dataset público mantido pela comunidade no repositório [Brasileirao_Dataset](https://github.com/adaoduque/Brasileirao_Dataset).
