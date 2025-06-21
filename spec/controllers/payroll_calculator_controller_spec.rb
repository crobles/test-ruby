require 'rails_helper'

RSpec.describe PayrollCalculatorController, type: :controller do
  describe 'GET #index' do
    it 'devuelve una respuesta exitosa' do
      get :index
      expect(response).to be_successful
    end

    it 'renderiza el template index' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'inicializa @calculation_result como nil' do
      get :index
      expect(assigns(:calculation_result)).to be_nil
    end
  end

  describe 'POST #calculate' do
    context 'para Chile - Gratificación Legal' do
      let(:params_chile) do
        {
          country: 'chile',
          sueldo_base_mensual: '1200000',
          ingreso_minimo_mensual: '460000'
        }
      end

      it 'calcula correctamente la gratificación' do
        post :calculate, params: params_chile
        
        result = assigns(:calculation_result)
        expect(result[:country]).to eq('Chile')
        expect(result[:concept]).to eq('Gratificación Legal')
        expect(result[:amount]).to eq(2_185_000)
        expect(result[:currency]).to eq('CLP')
      end

      it 'incluye el breakdown del cálculo' do
        post :calculate, params: params_chile
        
        result = assigns(:calculation_result)
        expect(result[:breakdown]).to include(:porcentaje_anual, :tope_legal, :explanation)
        expect(result[:breakdown][:porcentaje_anual]).to eq(3_600_000)
        expect(result[:breakdown][:tope_legal]).to eq(2_185_000)
      end
    end

    context 'para México - Aguinaldo' do
      let(:params_mexico) do
        {
          country: 'mexico',
          salario_diario: '1000',
          dias_trabajados_año: '365'
        }
      end

      it 'calcula correctamente el aguinaldo' do
        post :calculate, params: params_mexico
        
        result = assigns(:calculation_result)
        expect(result[:country]).to eq('México')
        expect(result[:concept]).to eq('Aguinaldo')
        expect(result[:amount]).to eq(15_000)
        expect(result[:currency]).to eq('MXN')
      end
    end

    context 'para Colombia - Prima de Servicios' do
      let(:params_colombia) do
        {
          country: 'colombia',
          salario_mensual: '2000000',
          dias_trabajados_semestre: '180'
        }
      end

      it 'calcula correctamente la prima' do
        post :calculate, params: params_colombia
        
        result = assigns(:calculation_result)
        expect(result[:country]).to eq('Colombia')
        expect(result[:concept]).to eq('Prima de Servicios')
        expect(result[:amount]).to eq(1_000_000)
        expect(result[:currency]).to eq('COP')
      end
    end

    context 'con país inválido' do
      it 'devuelve un error' do
        post :calculate, params: { country: 'invalid' }
        
        result = assigns(:calculation_result)
        expect(result[:error]).to eq("País 'invalid' no válido.")
      end
    end
  end
end