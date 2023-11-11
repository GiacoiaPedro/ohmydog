# frozen_string_literal: true


  class Users::RegistrationsController < Devise::RegistrationsController
    skip_before_action :require_no_authentication, only: [:new, :create]
  
    def create
      build_resource(sign_up_params)
  
      resource.save
      yield resource if block_given?
      if resource.persisted?
        set_flash_message! :notice, :signed_up
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with resource
      end
    end
  end
