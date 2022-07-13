class ApplicationController < ActionController::API
    before_action :authenticate_request
    attr_reader :current_user
    
    include ExceptionHandler

    
    def current_ability
      @current_ability ||= Ability.new(@current_user)
    end

    rescue_from CanCan::AccessDenied do |exception|
      render json: {
        is_successfully: false,
        message: "Unauthorized user",
        data: {},
        errors: "You are not authorized to perform this action"
      }, status: :unauthorized
    end

    @current_user = {}
    private
    def authenticate_request
      @current_user = AuthorizeApiRequest.call(request.headers).result
        render json: {
          is_successfully: false,
          message: "Unauthorized user",
          data: {},
          errors: "Unauthorized user"
        }, status: :unauthorized unless @current_user
    end
  end