module ApplicationHelper
  def admin_user!
    render json: { message: 'You are not admin' } unless current_api_v1_user.role == 'admin'
  end
end
