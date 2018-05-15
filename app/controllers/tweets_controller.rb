class TweetsController < ApplicationController

  before_action :set_data, only: [:destroy]

  def index
    @tweet = Tweet.new
    @tweets = Tweet.all
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.save
    redirect_to root_path
  end

  def destroy
    @tweet.destroy
    redirect_to root_path
  end

  def submit
    message = { input: params[:input]}
    render json: message
  end

  private
    def set_data
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:body)
    end
end
