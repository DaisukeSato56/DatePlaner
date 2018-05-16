class TweetsController < ApplicationController

  before_action :set_data, only: [:destroy]

  def index
    @tweet = Tweet.new
    @tweets = Tweet.all
  end

  def create
    # params[:input]の内容をジオコーダーで取得し、緯度経度情報の取得
    # 緯度経度情報を元にgoogleplacesAPIを用いて、周辺の施設を検索
    # 施設情報の中からランダムで１つ抽出し、並べる
    @tweet = Tweet.new(tweet_params)
    @tweet.save
    respond_to do |format|
      format.html { redirect_to root_path  }
      format.json
    end
  end

  def destroy
    @tweet.destroy
    redirect_to root_path
  end

  private
    def set_data
      @tweet = Tweet.find(params[:id])
    end

    def tweet_params
      params.require(:tweet).permit(:body)
    end
end
