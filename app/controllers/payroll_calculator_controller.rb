class PayrollCalculatorController < ApplicationController
  def index
    @calculation_result = nil
  end

  def calculate
    @country = params[:country]
    @calculation_result = calculate_concept
    render :index
  end

  private

  def calculate_concept
    case @country
    when 'chile'
      calculate_gratificacion_legal
    when 'mexico'
      calculate_aguinaldo
    when 'colombia'
      calculate_prima_servicios
    else
      { error: "País '#{@country}' no válido." }
    end
  end

  def calculate_gratificacion_legal
    sueldo_base = params[:sueldo_base_mensual].to_f
    ingreso_minimo = params[:ingreso_minimo_mensual].to_f

    porcentaje_anual = sueldo_base * 12 * 0.25
    tope_legal = ingreso_minimo * 4.75
    monto_calculado = [porcentaje_anual, tope_legal].min

    {
      country: 'Chile',
      concept: 'Gratificación Legal',
      amount: monto_calculado,
      currency: 'CLP',
      breakdown: {
        porcentaje_anual: porcentaje_anual,
        tope_legal: tope_legal,
        explanation: "25% del sueldo anual ($#{number_with_delimeter(porcentaje_anual.to_i)}), tope legal ($#{number_with_delimeter(tope_legal.to_i)}). Se paga el menor."
      }
    }
  end

  def calculate_aguinaldo
    salario_diario = params[:salario_diario].to_f
    dias_trabajados = params[:dias_trabajados_año].to_i

    monto_calculado = salario_diario * 15 * (dias_trabajados / 365.0)

    {
      country: 'México',
      concept: 'Aguinaldo',
      amount: monto_calculado,
      currency: 'MXN',
      breakdown: {
        explanation: "Salario diario ($#{number_with_delimeter(salario_diario.to_i)}) x 15 días x (#{dias_trabajados}/365) = $#{number_with_delimeter(monto_calculado.round(0))}"
      }
    }
  end

  def calculate_prima_servicios
    salario_mensual = params[:salario_mensual].to_f
    dias_trabajados = params[:dias_trabajados_semestre].to_i

    monto_calculado = (salario_mensual * dias_trabajados) / 360.0

    {
      country: 'Colombia',
      concept: 'Prima de Servicios',
      amount: monto_calculado,
      currency: 'COP',
      breakdown: {
        explanation: "($#{number_with_delimeter(salario_mensual.to_i)} x #{dias_trabajados}) / 360 = $#{number_with_delimeter(monto_calculado.round(0))}"
      }
    }
  end

    def number_with_delimeter(number)
      number.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1.').reverse
    end
  end


