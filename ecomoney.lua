-- ============================================
-- EcoMoney: control simple de ingresos, gastos
-- y meta de ahorro
-- Lenguaje: Lua
-- ============================================

-- FUNCION 1: pide un numero al usuario y lo valida.
-- Se repite hasta que el usuario escriba un numero valido (>= 0).
local function leerNumero(mensaje)
  while true do
    io.write(mensaje)
    local texto = io.read()          -- lee lo que escribe el usuario
    if texto == nil then os.exit() end -- por si se cierra la entrada

    local numero = tonumber(texto)   -- convierte el texto a numero
    if numero ~= nil and numero >= 0 then
      return numero
    end
    print("  Valor invalido. Escribe un numero mayor o igual a 0.")
  end
end

-- FUNCION 2: calcula el saldo disponible.
local function calcularSaldo(ingresos, gastos)
  return ingresos - gastos
end

-- FUNCION 3: da formato de dinero (soles con 2 decimales).
local function formatear(monto)
  return string.format("S/ %.2f", monto)
end

-- FUNCION 4: muestra el resultado segun el saldo y la meta.
local function mostrarResultado(ingresos, gastos, meta)
  local saldo = calcularSaldo(ingresos, gastos)

  print("")
  print("========== RESUMEN ECOMONEY ==========")
  print("Ingresos:        " .. formatear(ingresos))
  print("Gastos:          " .. formatear(gastos))
  print("Saldo:           " .. formatear(saldo))
  print("Meta de ahorro:  " .. formatear(meta))
  print("--------------------------------------")

  if saldo < 0 then
    print("ALERTA: gastaste mas de lo que ingresaste.")
    print("Estas en deuda por " .. formatear(-saldo))
  elseif saldo >= meta then
    print("META ALCANZADA!")
    print("Te sobran " .. formatear(saldo - meta) .. " despues de ahorrar.")
  else
    local falta = meta - saldo
    local porcentaje = (saldo / meta) * 100
    print("Aun no llegas a tu meta.")
    print("Te faltan " .. formatear(falta))
    print(string.format("Avance: %.0f%%", porcentaje))
  end
  print("======================================")
end

-- PROGRAMA PRINCIPAL
local function main()
  print("====================================")
  print("        BIENVENIDO A ECOMONEY")
  print("====================================")

  local ingresos = leerNumero("Ingresos (S/): ")
  local gastos   = leerNumero("Gastos (S/): ")
  local meta     = leerNumero("Meta de ahorro (S/): ")

  mostrarResultado(ingresos, gastos, meta)

  -- Pausa para que la ventana no se cierre sola en Windows
  io.write("\nPresiona Enter para salir...")
  io.read()
end

main()