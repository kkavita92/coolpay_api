feature 'Creating and viewing recipients' do
  scenario 'can create a recipient' do
    visit('/')
    click_button 'Authenticate'
    fill_in('new_recipient', with: 'Lord Voldemort')
    click_button('Create')
    expect(page).to have_content 'Lord Voldemort'
  end
end
