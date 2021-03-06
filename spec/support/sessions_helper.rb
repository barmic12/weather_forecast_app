# frozen_string_literal: true

require 'rails_helper'
module SessionsHelper
  def log_in
    stub_current_user
  end

  def log_in_user(user)
    post '/login', params: { session: { email: user.email, password: user.password } }
  end

  def stub_current_user
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
end
