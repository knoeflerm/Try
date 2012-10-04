module SessionsHelper
  def sign_in(user)
    cookies.permanent[:remember_token] = user.remember_token
    current_user = user #This line gest converted to current_user=(user) and then somehow calls that method.
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= user_from_remember_token #calls user_from_remember_token method if @current_user is nil or false. otherwice returns @current_user. Can be understood as @current_user = @current_user || user_from_remember_token 
  end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end
  
  private

    def user_from_remember_token
      remember_token = cookies[:remember_token]
      User.find_by_remember_token(remember_token) unless remember_token.nil?
    end
end
