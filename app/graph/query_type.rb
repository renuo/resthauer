QueryType = GraphQL::ObjectType.define do
  name 'Query'
  description 'The query root of this schema'

  field :menu do
    type MenuType
    argument :id, !types.ID
    description 'Find a Menu by ID'
    resolve ->(_obj, args, _ctx) { Menu.find(args['id']) }
  end
end
