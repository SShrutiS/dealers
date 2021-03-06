require 'rails_helper'

RSpec.feature "Cars", type: :feature do
  scenario 'User views the /cars page' do  # scenario is what is happening from user's perspective
      car = Car.first
      visit '/cars'
      expect(page).to have_text('Cars')
      expect(page).to have_text('Toyota')
      expect(page.html).to include('<h1>Cars</h1>')
      expect(page).to have_link('New', href: '/cars/new')
      expect(page).to have_link(car.vin, href: "/cars/#{car.id}")
  end
  
  scenario 'User views their car show page' do
      car = Car.first
      visit '/cars'
      click_link car.vin
      expect(page).to have_text(car.vin)
      expect(page).to have_text(car.make)
      expect(page).to have_text(car.model)
      expect(page).to have_text(car.year)
      expect(page).to have_link('Edit', href: "/cars/#{car.id}/edit")
      expect(page).to have_link('Delete', href: "/cars/#{car.id}")
  end
  
  scenario 'User delete the car' do
       car = Car.first
       visit '/cars'
       click_link car.vin
       click_link 'Delete'
       expect(page).to have_text('Cars')
       expect(page).to_not have_text(car.vin)
   end
    
  scenario 'User creates a car' do
    visit '/cars/new'
    fill_in 'car[vin]', with: 'C0000000000000009'
    fill_in 'car[make]', with: 'AMC'
    fill_in 'car[model]', with: 'Gremlin'
    fill_in 'car[year]', with: '1973'
    click_button 'Create Car'
    expect(page).to have_text('C0000000000000009')
    expect(page).to have_text('AMC')
    expect(page).to have_text('Gremlin')
    expect(page).to have_text('1973')
  end

  context 'bad form data' do
    scenario 'User enters invalid year' do
      visit '/cars/new'
      fill_in 'car[vin]', with: 'C0000000000000009'
      fill_in 'car[make]', with: 'AMC'
      fill_in 'car[model]', with: 'Gremlin'
      fill_in 'car[year]', with: '1700'
      click_button 'Create Car'
      expect(page).to have_text('Year is not between 1900 and 2020')
    end
    scenario 'User does not enter make, model' do
      visit '/cars/new'
      fill_in 'car[vin]', with: 'C0000000000000009'
      fill_in 'car[year]', with: '1973'
      click_button 'Create Car'
      expect(page).to have_text("Make can't be blank")
      expect(page).to have_text("Model can't be blank")
    end
  end

  scenario 'User updates a car' do
    car = Car.first
    visit "/cars/#{car.id}/edit"
    fill_in 'car[make]', with: 'Ferrari'
    click_button 'Update Car'
    expect(page).to have_text('Ferrari')
    expect(page).to have_text(car.vin)
    expect(page).to have_current_path("/cars/#{car.id}")
  end

  scenario 'User does not updates a car - bad vin' do
    car = Car.first
    visit "/cars/#{car.id}/edit"
    fill_in 'car[vin]', with: 'lolz'
    click_button 'Update Car'
    expect(page).to have_text('Vin invalid representation')
  end
end