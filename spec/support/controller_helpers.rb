module ControllerHelpers
  def login(user)
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in(user)
  end

  def login_courier(user)
    @request.env['devise.mapping'] = Devise.mappings[:delivery_person]
    sign_in(user)
  end
end