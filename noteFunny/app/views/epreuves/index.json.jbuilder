json.array!(@epreuves) do |epreufe|
  json.extract! epreufe, :id
  json.url epreufe_url(epreufe, format: :json)
end
