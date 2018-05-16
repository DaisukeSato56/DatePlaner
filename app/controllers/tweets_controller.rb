require 'net/http'
require 'uri'
require 'pry'
require 'json'

class TweetsController < ApplicationController

  before_action :set_data, only: [:destroy]

  def index
    @tweet = Tweet.new
    @tweets = Tweet.all
  end

  def create
    # 緯度経度情報を元にgoogleplacesAPIを用いて、周辺の施設を検索
    # 施設情報の中からランダムで１つ抽出し、並べる
    @tweet = Tweet.new(tweet_params)
    @tweet.save

    googleplacesAPI = ENV['googlePlacesAPIKey']

    lat = @tweet.latitude
    lng = @tweet.longitude
    rad = 2000
    language = 'ja'

    places = [ ["restaurant"], ["aquarium", "park", "museum", "shopping_mall"], ["cafe"] ]

    result_places = []
    places.each do |place|
      types = place[rand(place.length)]

      url = URI.parse(URI.escape("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=#{lat},#{lng}&radius=#{rad}&types=#{types}&sensor=false&language=ja&key=#{googleplacesAPI}"))
      res = Net::HTTP.start(url.host, url.port, use_ssl: true) { |http|
        http.get(url.path + '?' + url.query);
      }

      obj = JSON.parse(res.body)
      result_places << obj["results"][rand(obj["results"].length)]["name"]
    end

    # objのresultsキーの0番目の配列の要素の中のnameキーを取得する
    # obj["results"][0]["name"]

    respond_to do |format|
      format.html { redirect_to controller: 'tweets', action: 'index' }
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
      params.require(:tweet).permit(:address)
    end
end
