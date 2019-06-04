# frozen_string_literal: true

module SessionsHelper
  def account_navigation
    if current_user
      link_to t('sessions.form.logout'), logout_path, class: 'nav-link', method: :delete
    else
      link_to t('sessions.form.sign_in_or_sign_up'), login_path, class: 'nav-link'
    end
  end

end
