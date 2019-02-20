feature 'Logging into app' do
  scenario 'can authenticate to app' do
    visit('/')
    click_button 'Authenticate'
    expect(current_path).to eq '/home'
  end
end
