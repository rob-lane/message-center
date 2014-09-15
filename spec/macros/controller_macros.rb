module ControllerMacros

  def login_user
    before do
      request.env["devise.mapping"] = Devise.mappings[:admin]
      @user = FactoryGirl.create(:user)
      sign_in @user
    end
  end

end