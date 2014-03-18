admin = User.create(
    :name => "Administrator",
    :role => "admin"
    :email => "admin@own.com",
    :password => "password",
    :password_confirmation => "password"
)
admin.toggle!(:admin)
