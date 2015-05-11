json.partial! 'authentication/user', user: @user if @user
json.partial! 'authentication/token', token: @token if @token
json.error @error
