json.array!(@matieres) do |matiere|
  json.extract! matiere, :id
  json.url matiere_url(matiere, format: :json)
end
