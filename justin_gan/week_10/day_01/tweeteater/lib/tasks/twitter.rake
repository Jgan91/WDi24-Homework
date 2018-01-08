namespace :twitter do
  desc "Removes all Users and Tweets from the database"
  task :clear => :environment do
    User.destroy_all
    Tweet.destroy_all
    Rake::Task['twitter:stats'].invoke
  end

  task :stats => :environment do
    puts "Users: #{ User.count }, Tweets: #{ Tweet.count }"
  end

  desc "This populates the tweet and user tables with Faker data"
  task :populate, [:user_count] => :environment do |t, args|
    args[:user_count].to_i.times do
      user = User.create :email => Faker::Internet.email
      rand(1..50).times do
        user.tweets.create :content => Faker::RickAndMorty.quote
      end
    end
    Rake::Task['twitter:stats'].invoke
  end

  desc "Populates the Tweet table with real live data from Twitter"
  task :search, [:query, :count] => :environment do |t, args|
    puts "Searching Twitter for #{ args[:count] } tweets mentioning #{ args[:query] }"
    # YOUR CODE (mostly) GOES HERE (do not worry about Users)
  end
end
