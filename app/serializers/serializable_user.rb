class SerializableUser < JSONAPI::Serializable::Resource
  binding.pry
  type 'users'
  attributes :id, :first_name, :last_name, :email

  link :self do
    @url_helpers.api_v1_user_url(@object.id)
  end
end
