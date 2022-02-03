class Users::SessionsController < Devise::SessionsController
    skip_before_action :verify_authenticity_token
    # respond_to :json
  
    def new
        respond_to do |format|
          format.html { @user = User.new }
          format.json { render json: { message: "You are logged out." }, status: :ok }
        end
    end

    private
  
    def respond_with(resource, _opts = {})
      render json: { message: 'You are logged in.' }, status: :ok
    end
  
    def respond_to_on_destroy
      log_out_success && return if current_user
  
      log_out_failure
    end
  
    def log_out_success
      render json: { message: "You are logged out." }, status: :ok
    end
  
    def log_out_failure
      render json: { message: "Hmm nothing happened."}, status: :unauthorized
    end
  end