#RESULTADO FINAL

resultado <- r25_analise |> 
  summarise(
    acerto_z4_pts = mean(rebaixado[z4_pts]) * 100,
    acerto_z4_saldo = mean(rebaixado[z4_saldo]) * 100
  )

print(resultado)

# ANALISANDO RESULTADOS
cat("--- MATRIZ DE CONFUSÃO: Z4 POR PONTOS ---\n")
table(Previsao = r25_analise$z4_pts, Real = r25_analise$rebaixado)

cat("\n--- MATRIZ DE CONFUSÃO: Z4 POR SALDO ---\n")
table(Previsao = r25_analise$z4_saldo, Real = r25_analise$rebaixado)

# Removendo qualquer agrupamento anterior para pegar todos os 380 registros
r25_desagrupado <- r25_analise |>  ungroup()

# 2. Tabela Comparativa de Métricas Estatísticas
metricas_globais <- r25_desagrupado |> 
  summarise(
    # Z4 Pontos
    TP_pts = sum(z4_pts & rebaixado),
    FP_pts = sum(z4_pts & !rebaixado),
    TN_pts = sum(!z4_pts & !rebaixado),
    FN_pts = sum(!z4_pts & rebaixado),
    
    # Z4 Saldo
    TP_saldo = sum(z4_saldo & rebaixado),
    FP_saldo = sum(z4_saldo & !rebaixado),
    TN_saldo = sum(!z4_saldo & !rebaixado),
    FN_saldo = sum(!z4_saldo & rebaixado)
  ) |> 
  pivot_longer(everything()) |> 
  separate(name, into = c("metrica", "modelo"), sep = "_") |> 
  pivot_wider(names_from = metrica, values_from = value) |> 
  mutate(
    Acuracia_Global = (TP + TN) / (TP + TN + FP + FN) * 100,
    Sensibilidade_Recall = (TP / (TP + FN)) * 100,
    Especificidade = (TN / (TN + FP)) * 100,
    Precisao = (TP / (TP + FP)) * 100,
    F1_Score = 2 * (Precisao * Sensibilidade_Recall) / (Precisao + Sensibilidade_Recall)
  )

print(metricas_globais)

