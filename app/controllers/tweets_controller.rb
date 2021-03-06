class TweetsController < ApplicationController
  #index action
  get '/tweets' do
    if logged_in?
      @user= current_user
      @tweets = Tweet.all
      erb :"tweets/tweets"
    else
      redirect "login"
    end
  end
  #new action
  get '/tweets/new' do
    if logged_in?
      erb :"tweets/create_tweet"
    else
      redirect "login"
    end
  end
  #create action
  post '/tweets' do
    if logged_in?
      tweet = Tweet.create(params)
      if tweet.valid?
        tweet.user=current_user
        tweet.save
        redirect "tweets/#{tweet.id}"
      else
        redirect "tweets/new"
      end
    else
      redirect "login"
    end
  end
  #show action
  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.all.find_by(id: params[:id])
      if !!@tweet
        erb :"tweets/show_tweet"
      else
        redirect 'tweets'
      end
    else
      redirect "login"
    end
  end
  #edit action
  get '/tweets/:id/edit' do
    if logged_in?
      if @tweet = current_user.tweets.find_by(id: params[:id])
        erb :"tweets/edit_tweet"
      else
        redirect 'tweets'
      end
    else
      redirect "login"
    end
  end
  patch '/tweets/:id' do
    if logged_in?
      tweet = current_user.tweets.find_by(id: params[:id])
      if tweet.update(content: params[:content])
        redirect "tweets/#{tweet.id}"
      else
        redirect "tweets/#{tweet.id}/edit"
      end
    else
      redirect "login"
    end
  end
  #delete action
  delete '/tweets/:id/delete' do
    if logged_in?
      tweet=current_user.tweets.find_by(id: params[:id])
      if tweet
        tweet.destroy
        redirect "tweets"
      else
        redirect "tweets/#{params[:id]}"
      end
    else
      redirect "login"
    end
  end
end
