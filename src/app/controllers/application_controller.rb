class ApplicationController < ActionController::Base
  before_action :apijson_pagination, if: :json_request? # action to jwt authorization
  before_action :set_locale # Setting the Locale from param
  skip_before_action :verify_authenticity_token, if: :json_request? # Skip csrf to api

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def json_request?
    request.format.json?
  end

  def underscore_params_key_transform
    underscore_params = params.clone
    params.each do |key, value|
      underscore_params[key.underscore] = value
    end
    underscore_params
  end

  def apijson_pagination
    if params[:page].present?
      params[:limit] = params[:page][:size] if params[:page][:size].present?
      params[:page] = if params[:page][:number].present?
                        params[:page][:number]
                      else
                        1
                      end
    end
    params[:sort] = '-id' if params[:sort].blank?
  end

end
