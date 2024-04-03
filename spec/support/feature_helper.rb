module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end

  def sign_in_courier(delivery_person)
    visit new_delivery_person_session_path
    fill_in 'Email', with: delivery_person.email
    fill_in 'Password', with: delivery_person.password
    click_on 'Log in'
  end
end