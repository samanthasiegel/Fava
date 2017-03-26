json.extract! fava_user, :id, :first_name, :last_name, :email, :phone, :created_at, :updated_at
json.url fava_user_url(fava_user, format: :json)
