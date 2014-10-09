json.array!(@images) do |image|
  json.extract! image, :id, :tag, :binary_data, :filename
  json.url image_url(image, format: :json)
end
