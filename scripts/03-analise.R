# MAPEANDO REBAIXADOS NA RODADA 38

rebaixados_reais <- jogos |> 
  group_by(ano, time) |> 
  summarise(
    pts_38 = sum(pontos, na_rm = TRUE),
    saldo_38 = sum(saldo, na_rm = TRUE),
    gols_pro_38 = sum(gols_pro, na_rm = TRUE),
    .groups = "drop"
  ) |> 
  group_by(ano) |> 
  arrange(ano, desc(pts_38), desc(saldo_38), desc(gols_pro_38)) |> 
  mutate(posicao_final = row_number()) |> 
  filter(posicao_final >= 17) |> 
  mutate(rebaixado = TRUE) |> 
  select(ano, time, rebaixado)

#COMPARANDO Z4 PONTOS VS Z4 SALDO NA RODADA 25
r25_analise <- jogos |> 
  filter(rodada <= 25) |> 
  group_by(ano, time) |> 
  summarise(
    pts_r25 = sum(pontos, na_rm = TRUE),
    saldo_r25 = sum(saldo, na_rm = TRUE),
    gols_pro_r25 = sum(gols_pro, na_rm = TRUE),
    .groups = "drop"
  ) |> 
  group_by(ano) |> 
  mutate(
    rank_pts = rank(pts_r25, ties.method = "first"),
    z4_pts = rank_pts <= 4,
    
    rank_saldo = rank(saldo_r25, ties.method = "first"),
    z4_saldo = rank_saldo <= 4
  ) |> 
  left_join(rebaixados_reais, by = c("ano", "time")) |> 
  mutate(rebaixado = coalesce(rebaixado, FALSE))
