class Api::NewsController < Api::ApplicationController
  before_action :set_news, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: [:index, :latest, :show]

  def index
    if params[:count]
      @news = News.order(created_at: :desc).limit(params[:count])
    else
      @news = News.order(created_at: :desc).all
    end
    render json: @news
  end

  def show
    render json: @news
  end

  def create
    @news = News.new(news_params)
    authorize @news
    if @news.save
      render json: @news, status: 201
    else
      render json: @news, status: 422
    end
  end

  def update
    authorize @news
    if @news.update_attributes(news_params)
      render json: @news, status: 200
    else
      render json: @news, status: 422
    end
  end

  def destroy
    authorize @news
    @news.destroy
    head 200
  end

  private

  def set_news
    @news = News.find(params[:id])
  end

  def news_params
    ActionController::Parameters.new(JSON.parse(request.body.read)).
      permit(
        :text
    )
  end
end
