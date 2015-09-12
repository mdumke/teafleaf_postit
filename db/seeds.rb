# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

# create users
['Luke', 'Clara', 'Graham'].each do |name|
  User.create(username: name)
end

# create posts
Post.create([
  { title: 'In the morning', description: 'The sun is rising', user_id: 3 },
  { title: 'At noon', description: 'showdown', user_id: 3 },
  { title: 'In the afternoon', description: 'Let us have a tea', user_id: 3 },
  { title: 'Late at night',
    description: 'Taking drugs at the lakeside',
    user_id: 2 }
])

# create comments
Comment.create([
  { body: 'Makes sense.', user_id: 1, post_id: 1 },
  { body: 'No way.', user_id: 1, post_id: 2 },
  { body: 'I agree', user_id: 2, post_id: 1 },
  { body: 'Interesting thought', user_id: 3, post_id: 1 }
])

# create categories
['food', 'nature', 'sports'].each do |name|
  Category.create(name: name)
end
