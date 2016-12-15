RatingType = GraphQL::ObjectType.define do
  name 'Rating'
  description 'A rating of a person regarding a menu'
  # `!` marks a field as "non-null"
  field :id, !types.ID
  field :value, !types.Int
  field :menu, !MenuType
  field :user, !UserType
end
