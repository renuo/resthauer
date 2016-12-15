MenuType = GraphQL::ObjectType.define do
  title 'Menu'
  description 'Some lunch menu you can rate'
  # `!` marks a field as "non-null"
  field :id, !types.ID
  field :title, !types.String
  field :description, !types.String
  field :ratings, types[RatingType]
end
