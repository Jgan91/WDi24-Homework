namespace :twitter do
  # client = Twitter::REST::Client.new do |config|
  #   config.consumer_key        = "PAW7uMHjgonnunIhbjGBqqQBM"
  #   config.consumer_secret     = "IkaUTrDJ3U3RW0BaSfwUgbiPQcEnFQnrTtvoziein7UP7MJfOm"
  #   config.access_token        = "936726502632124416-njDFoWZKlaHxIikw7PPuJUag979IJ9M"
  #   config.access_token_secret = "ELDjo41tVoBOzmQtoU18nro9AMsD6GRlBtctAyZ4Tfd4j"
  # end

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
    $client.search(args[:query], :result_type => 'recent').take(args[:count].to_i).collect do |tweet|
      p tweet.text
      Tweet.create :content => tweet.text
    end
    Rake::Task['twitter:stats'].invoke
  end
end
