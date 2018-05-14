class TweetsController < ApplicationController

  def index
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.save
    redirect_to root_path
  end

  private
    def tweet_params
      params.require(:tweet).permit(:body)
    end
end
