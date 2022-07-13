module ExceptionHandler
    extend ActiveSupport::Concern
  
     # Define custom error subclasses - rescue catches `StandardErrors`
    class AuthenticationError < StandardError; end
    class MissingToken < StandardError; end
    class InvalidToken < StandardError; end
    class ExpiredSignature < StandardError; end
    class DecodeError < StandardError; end
    
    included do
      # Define custom handlers
      rescue_from ActiveRecord::RecordInvalid, with: :four_twenty_two
      rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized_request
      rescue_from ExceptionHandler::MissingToken, with: :four_twenty_two
      rescue_from ExceptionHandler::InvalidToken, with: :four_twenty_two
      rescue_from ExceptionHandler::ExpiredSignature, with: :four_ninety_eight
      rescue_from ExceptionHandler::DecodeError, with: :four_zero_one
  
      rescue_from ActiveRecord::RecordNotFound do |e|
        render json: {
          is_successfully: false,
          message: "Unauthorized user",
          data: {access_token: ""},
          errors: e.message
        }, status: :unauthorized
      end
  
      rescue_from ActiveRecord::RecordInvalid do |e|
        rrender json: {
          is_successfully: false,
          message: "Unauthorized user",
          data: {access_token: ""},
          errors: e.message
        }, status: :unauthorized
      end
    end
  
    private
  
    # JSON response with message; Status code 401 - Unauthorized
    def four_twenty_two(e)
      render json: {
        is_successfully: false,
        message: "Unauthorized user",
        data: {access_token: ""},
        errors: e.message
      }, status: :unauthorized
    end
   
  # JSON response with message; Status code 401 - Unauthorized
    def four_ninety_eight(e)
      render json: {
        is_successfully: false,
        message: "Unauthorized user",
        data: {access_token: ""},
        errors: e.message
      }, status: :unauthorized
    end
  
    # JSON response with message; Status code 401 - Unauthorized
    def four_zero_one(e)
      render json: {
        is_successfully: false,
        message: "Unauthorized user",
        data: {access_token: ""},
        errors: e.message
      }, status: :unauthorized
    end
  
     # JSON response with message; Status code 401 - Unauthorized
    def unauthorized_request(e)
      render json: {
        is_successfully: false,
        message: "Unauthorized user",
        data: {access_token: ""},
        errors: e.message
      }, status: :unauthorized
    end
  end