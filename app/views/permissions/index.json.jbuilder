json.array!(@permissions) do |permission|
  json.extract! permission, :id, :user_id, :projects_id
  json.url permission_url(permission, format: :json)
end
