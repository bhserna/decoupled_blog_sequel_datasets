Sequel.migration do
  up do
    create_table(:posts) do
      primary_key :id
      String :title
      String :description, text: true
      String :body, text: true
      DateTime :created_at
    end
  end

  down do
    drop_table(:posts)
  end
end
