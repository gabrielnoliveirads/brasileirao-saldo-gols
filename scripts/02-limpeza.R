# TRATAMENTO INICIAL DOS DADOS

jogos <- dados_raw |> 
  mutate(
    data = dmy(data),
    ano = year(data),
    rodada = as.numeric(rodata)
  )  |> 
  filter(ano >= 2006) |> 
  pivot_longer(
    cols = c(mandante, visitante),
    names_to = "mando",
    values_to = "time"
  )  |> 
  mutate(
    gols_pro = if_else(mando == "mandante", mandante_Placar, visitante_Placar),
    gols_contra = if_else(mando == "mandante", visitante_Placar, mandante_Placar),
    saldo = gols_pro - gols_contra,
    pontos = case_when(
      gols_pro > gols_contra ~ 3,
      gols_pro == gols_contra ~ 1,
      TRUE ~ 0
    )
  )
  