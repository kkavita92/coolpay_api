feature 'Paying recipients' do
  scenario 'can pay a recipient' do
    visit('/')
    click_button 'Authenticate'
    fill_in('amount', with: 200)
    click_button('Make Payment')
    expect(page).to have_content '"amount"=>"200"'
  end
end
