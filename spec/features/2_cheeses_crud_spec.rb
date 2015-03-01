require 'rails_helper'

feature 'Existing users CRUD cheese' do
  scenario 'index lists all available cheeses with name, price_per_lb' do
    cheddar = Cheese.new(name: 'Cheddar', price_per_lb: 4.25)
    cheddar.save!
    gouda = Cheese.new(name: 'Gouda', price_per_lb: 7.25)
    gouda.save!

    sign_in_user
    expect(current_path).to eq cheeses_path

    expect(page).to have_content 'Cheddar - $4.25'
    expect(page).to have_content 'Gouda - $7.25'
    expect(page).to have_link 'New Cheese'
  end

  scenario 'can make a new cheese from the new cheese form' do
    sign_in_user
    click_link 'New Cheese'

    expect(current_path).to eq new_cheese_path

    fill_in :cheese_name, with: 'Ruby Cheese'
    fill_in :cheese_price_per_lb, with: 2.01
    click_button 'Create Cheese'

    expect(current_path).to eq cheeses_path
    expect(page).to have_content 'Cheese created successfully!'
    expect(page).to have_content 'Ruby Cheese - $2.01'
  end

  scenario 'index links to show via the cheese name and price' do
    gouda = Cheese.new(name: 'Gouda', price_per_lb: 7.25)
    gouda.save!
    sign_in_user

    click_link 'Gouda - $7.25'

    expect(current_path).to eq cheese_path(gouda)
    expect(page).to have_content 'Cheese Name: Gouda'
    expect(page).to have_content 'Cheese Price ($/lb): $7.25'
  end

  scenario 'show contains links to the index, edit, and destroy actions' do
    gouda = Cheese.new(name: 'Gouda', price_per_lb: 7.25)
    gouda.save!
    sign_in_user

    click_link 'Gouda - $7.25'

    expect(current_path).to eq cheese_path(gouda)
    expect(find_link('Index')[:href]).to eq(cheeses_path)
    expect(find_link('Edit')[:href]).to eq(edit_cheese_path(gouda))
    expect(find_link('Destroy')[:href]).to eq(cheese_path(gouda))
  end

  scenario 'can update cheeses' do
    gouda = Cheese.new(name: 'Gouda', price_per_lb: 7.25)
    gouda.save!
    sign_in_user

    click_link 'Gouda - $7.25'
    click_link 'Edit'
    expect(current_path).to eq edit_cheese_path(gouda)

    fill_in :cheese_name, with: 'Mega Gouda'
    fill_in :cheese_price_per_lb, with: 14.50
    click_button 'Update Cheese'

    expect(page).to have_content 'Cheese updated successfully!'
    expect(current_path).to eq(cheese_path(gouda))
  end

  scenario 'clicking the destroy link on show page destroys the cheese and redirects to cheeses index' do
    gouda = Cheese.new(name: 'Gouda', price_per_lb: 7.25)
    gouda.save!
    sign_in_user

    click_link 'Gouda - $7.25'
    click_link 'Destroy'

    expect(current_path).to eq cheeses_path
    expect(page).to have_content 'Deleted cheese: Gouda'

    expect { gouda.reload }.to raise_error ActiveRecord::RecordNotFound
  end
end

feature 'Unauthenticated users cannot CRUD cheese' do
  scenario 'attempt to login by an unauthenticated user causes a flash message and redirect' do
    visit cheeses_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'You must register or log in before you can do that!'
  end
end
