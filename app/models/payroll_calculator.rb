class PayrollCalculator
  COUNTRIES = {
    'chile' => {
      name: 'Chile',
      currency: 'CLP',
      concepts: 'Gratificación Legal',
    },
    'mexico' => {
      name: 'México',
      currency: 'MXN',
      concepts: 'Aguinaldo',
    },
    'colombia' => {
      name: 'Colombia',
      currency: 'COP',
      concepts: 'Prima de Servicios',
    }
  }.freeze

  def self.calculate_gratificacion_legal(sueldo_base_mensual, ingreso_minimo_mensual)
    porcentaje_anual = sueldo_base_mensual * 12 * 0.25
    tope_legal = ingreso_minimo_mensual * 4.75
    [porcentaje_anual, tope_legal].min
  end

  def self.calculate_aguinaldo(salario_diario, dias_trabajados)
    salario_diario * 15 * (dias_trabajados / 365.0)
  end

  def self.calculate_prima_servicios(salario_mensual, dias_trabajados_semestre)
    (salario_mensual * dias_trabajados_semestre) / 360.0
  end

end