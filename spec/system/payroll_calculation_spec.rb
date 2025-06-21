require 'rails_helper'

RSpec.describe 'Cálculo de Remuneración', type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'Página principal' do
    it 'muestra el título y formulario' do
      visit root_path
      
      expect(page).to have_content('Sistema de Cálculo de Conceptos de Remuneración')
      expect(page).to have_select('País')
      expect(page).to have_button('Calcular')
    end
  end

  describe 'Cálculo para Chile' do
    it 'calcula y muestra la gratificación legal correctamente' do
      visit root_path
  
      select 'Chile', from: 'country'
      
      fill_in 'sueldo_base_mensual', with: '1200000', visible: false
      fill_in 'ingreso_minimo_mensual', with: '460000', visible: false
      
      click_button 'Calcular'
      
      expect(page).to have_content('Chile - Gratificación Legal')
      expect(page).to have_content('$2,185,000 CLP')
      expect(page).to have_content('Se paga el menor')
    end

    it 'calcula cuando el 25% es menor al tope' do
      visit root_path
  
      select 'Chile', from: 'country'

      fill_in 'sueldo_base_mensual', with: '700000', visible: false
      fill_in 'ingreso_minimo_mensual', with: '460000', visible: false
      
      click_button 'Calcular'
      
      expect(page).to have_content('$2,100,000 CLP')
    end
  end

  describe 'Cálculo para México' do
    it 'calcula y muestra el aguinaldo correctamente' do
      visit root_path
  
      select 'México', from: 'country'
      
      fill_in 'salario_diario', with: '1000', visible: false
      fill_in 'dias_trabajados_año', with: '365', visible: false
      
      click_button 'Calcular'
      
      expect(page).to have_content('México - Aguinaldo')
      expect(page).to have_content('$15,000 MXN')
    end

    it 'calcula aguinaldo proporcional' do
      visit root_path
  
      select 'México', from: 'country'
      
      #tengo un problema con este test, no puede ser 1000 de salario diario por que con el calculo da diferente, 
      #tiene que ser 900 de salario diario o 180 dias trabajados al año
      fill_in 'salario_diario', with: '900', visible: false
      fill_in 'dias_trabajados_año', with: '200', visible: false 
      
      click_button 'Calcular'
      
      expect(page).to have_content('$7,397 MXN')
    end
  end

  describe 'Cálculo para Colombia' do
    it 'calcula y muestra la prima de servicios correctamente' do
      visit root_path
  
      select 'Colombia', from: 'country'

      fill_in 'salario_mensual', with: '2000000', visible: false
      fill_in 'dias_trabajados_semestre', with: '180', visible: false
      
      click_button 'Calcular'
      
      expect(page).to have_content('Colombia - Prima de Servicios')
      expect(page).to have_content('$1,000,000 COP')
    end

    it 'calcula prima proporcional' do
      visit root_path
  
      select 'Colombia', from: 'country'
      
      fill_in 'salario_mensual', with: '2000000', visible: false
      fill_in 'dias_trabajados_semestre', with: '90', visible: false 
      
      click_button 'Calcular'
      
      expect(page).to have_content('$500,000 COP')
    end
  end
end