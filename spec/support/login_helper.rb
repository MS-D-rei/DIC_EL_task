module LoginHelper
  def first_user_log_in
    fill_in 'session[email]', with: first_user.email
    fill_in 'session[password]', with: first_user.password
    click_on 'Log in'
  end

  def second_user_log_in
    fill_in 'session[email]', with: second_user.email
    fill_in 'session[password]', with: second_user.password
    click_on 'Log in'
  end

  def log_out
    visit tasks_path
    click_on 'log out'
  end
end
