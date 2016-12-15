UserType = GraphQL::ObjectType.define do
  title 'User'
  description 'A person who rates menus'
  # `!` marks a field as "non-null"
  field :id, !types.ID
  field :name, !types.String
  field :ratings, types[RatingType]
end
