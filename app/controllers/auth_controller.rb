class AuthController < ApplicationController

    skip_before_action :authenticate_request, only: %i[login register]

    def register
        @user_data = User.create(register_params)
        if @user_data.save
            @user_result = {
                id: @user_data.id,
                full_name: "#{@user_data.first_name} #{@user_data.last_name}",
                email: @user_data.email,
                is_admin: @user_data.is_admin
            }
            render json: {
                is_successfully: true,
                message: "User account created successfully",
                data: @user_result,
                errors: {}
            }
        else
            render json: {
                is_successfully: false,
                data: {},
                message: "Failed to create user account",
                errors: @user_data.errors.messages
            }
        end
    end

    def login
        authenticate params[:email], params[:password]
    end
  
    def authenticate(email, password)
        command = AuthenticateUser.call(email, password)
        if command.success?
            @user_data = User.find_by_email(email)
            @user_result = {
                id: @user_data.id,
                full_name: "#{@user_data.first_name} #{@user_data.last_name}",
                email: @user_data.email,
                is_admin: @user_data.is_admin
            }
            render json: {
                is_successfully: true,
                message: "Login successfully",
                data: {access_token:command.result, user:@user_result},
                errors: {}
            }
        else
            render json: {
                is_successfully: false,
                message: "Failed login",
                data: {access_token: "", user: {}},
                errors: command.errors
            }, status: :unauthorized
        end
    end  


    private 

    def register_params
        params.permit(
            :first_name,
            :last_name,
            :email,
            :password
        )
    end
end
