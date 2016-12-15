MenuType = GraphQL::ObjectType.define do
  name 'Menu'
  description 'Some lunch menu you can rate'
  # `!` marks a field as "non-null"
  field :id, !types.ID
  field :title, !types.String
  field :price, !types.Float
  field :description, !types.String
  field :ratings, types[RatingType]
end

