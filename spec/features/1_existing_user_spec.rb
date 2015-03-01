require 'rails_helper'

feature 'Existing users' do
  scenario 'can log in to see the cheeses index' do
    user = User.new(email: 'foo@bar.com', password: 'supersecure')
    user.save!

    visit root_path
    click_link 'Sign in'

    expect(current_path).to eq '/sign-in'
    expect(page).to have_content 'Sign In Form'

    fill_in :email, with: user.email
    fill_in :password, with: 'supersecure'
    click_button 'Sign in'

    expect(current_path).to eq '/cheeses'
    expect(page).to have_content 'List of Cheeses'
    expect(page).to have_content 'Successfully signed in'
  end

  scenario 'are redirected back to the sign in form and shown a flash error if no such user exists' do
    visit root_path
    click_link 'Sign in'

    expect(current_path).to eq '/sign-in'
    expect(page).to have_content 'Sign In Form'

    fill_in :email, with: 'testMcTesterson@example.com'
    fill_in :password, with: 'password'
    click_button 'Sign in'

    expect(current_path).to eq '/sign-in'
    expect(page).to have_content 'User could not be authenticated. Please try again.'
  end
end
