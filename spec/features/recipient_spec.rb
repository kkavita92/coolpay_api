feature 'Creating and viewing recipients' do
  scenario 'can create a recipient' do
    visit('/')
    click_button 'Authenticate'
    fill_in('new_recipient', with: 'Barry Trotter')
    click_button('Confirm')
    expect(page).to have_content 'Barry Trotter'
  end
end
