Config = {}

-- Locais onde o marcador vai aparecer
Config.Locais = {
    { x = 441.83, y = -982.05, z = 30.69, text = "PONTO DA POLÍCIA" }, -- DP Mission Row
    { x = 299.12, y = -597.51, z = 43.28, text = "PONTO DO HOSPITAL" }, -- Hospital Pillbox
    { x = -347.11, y = -133.32, z = 39.01, text = "PONTO DA MECÂNICA" }, -- Mecânica LSC
    -- Copie e cole a linha acima para adicionar mais locais
}

-- Mapeamento manual para casos onde o nome não é apenas "Paisana"..Cargo
-- Exemplo: Se o cargo for "LiderMecanico" e o paisana for "MecanicoFolga"
Config.Excecoes = {
    ["LiderMecanico"] = "PaisanaMecanicoLider",
    ["PaisanaMecanicoLider"] = "LiderMecanico",
    -- ["CargoNormal"] = "CargoPaisana",
}