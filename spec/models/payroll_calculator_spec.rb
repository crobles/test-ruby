require 'rails_helper'

RSpec.describe PayrollCalculator, type: :model do
  describe '.calculate_gratificacion_legal' do
    context 'cuando el 25% del sueldo anual es menor al tope legal' do
      it 'devuelve el 25% del sueldo anual' do
        sueldo_base = 700_000
        ingreso_minimo = 460_000
        
        resultado = PayrollCalculator.calculate_gratificacion_legal(sueldo_base, ingreso_minimo)
        
        expect(resultado).to eq(2_100_000)
      end
    end

    context 'cuando el 25% del sueldo anual es mayor al tope legal' do
      it 'devuelve el tope legal' do
        sueldo_base = 1_200_000
        ingreso_minimo = 460_000
        
        resultado = PayrollCalculator.calculate_gratificacion_legal(sueldo_base, ingreso_minimo)
        
        expect(resultado).to eq(2_185_000)
      end
    end

    context 'cuando los valores son exactamente iguales' do
      it 'devuelve cualquiera de los dos valores' do
        sueldo_base = 730_000
        ingreso_minimo = 461_053
        
        resultado = PayrollCalculator.calculate_gratificacion_legal(sueldo_base, ingreso_minimo)
        
        expect(resultado).to be_within(1000).of(2_190_000)
      end
    end

    context 'con valores de entrada cero' do
      it 'devuelve cero' do
        resultado = PayrollCalculator.calculate_gratificacion_legal(0, 0)
        expect(resultado).to eq(0)
      end
    end
  end

  describe '.calculate_aguinaldo' do
    context 'con año completo trabajado' do
      it 'calcula el aguinaldo completo' do
        salario_diario = 1_000
        dias_trabajados = 365
        
        resultado = PayrollCalculator.calculate_aguinaldo(salario_diario, dias_trabajados)
        
        expect(resultado).to eq(15_000)
      end
    end

    context 'con medio año trabajado' do
      it 'calcula el aguinaldo proporcional' do
        salario_diario = 1_000
        dias_trabajados = 180
        
        resultado = PayrollCalculator.calculate_aguinaldo(salario_diario, dias_trabajados)
        
        expect(resultado).to be_within(1).of(7_397)
      end
    end

    context 'con un mes trabajado' do
      it 'calcula el aguinaldo proporcional' do
        salario_diario = 500
        dias_trabajados = 30
        
        resultado = PayrollCalculator.calculate_aguinaldo(salario_diario, dias_trabajados)
        
        expect(resultado).to be_within(1).of(616)
      end
    end

    context 'sin días trabajados' do
      it 'devuelve cero' do
        resultado = PayrollCalculator.calculate_aguinaldo(1000, 0)
        expect(resultado).to eq(0)
      end
    end
  end

  describe '.calculate_prima_servicios' do
    context 'con semestre completo' do
      it 'calcula la prima completa' do
        salario_mensual = 2_000_000
        dias_trabajados = 180
        
        resultado = PayrollCalculator.calculate_prima_servicios(salario_mensual, dias_trabajados)
        
        expect(resultado).to eq(1_000_000)
      end
    end

    context 'con medio semestre' do
      it 'calcula la prima proporcional' do
        salario_mensual = 2_000_000
        dias_trabajados = 90
        
        resultado = PayrollCalculator.calculate_prima_servicios(salario_mensual, dias_trabajados)
        
        expect(resultado).to eq(500_000)
      end
    end

    context 'con un mes trabajado' do
      it 'calcula la prima proporcional' do
        salario_mensual = 1_500_000
        dias_trabajados = 30
        
        resultado = PayrollCalculator.calculate_prima_servicios(salario_mensual, dias_trabajados)
        
        expect(resultado).to eq(125_000)
      end
    end

    context 'sin días trabajados' do
      it 'devuelve cero' do
        resultado = PayrollCalculator.calculate_prima_servicios(2_000_000, 0)
        expect(resultado).to eq(0)
      end
    end
  end
end