# frozen_string_literal: true 
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}

class Client < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3 }
  validates :phone, presence: true
  validates :date_stamp, presence: true
  validates :barber, presence: true
  validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

before do
  @barbers = Barber.all
end
get '/' do 
  @barbers = Barber.order 'created_at DESC'
  erb :index
end 

get '/visit' do
  @users = Client.new
  erb :visit
end

# Отправить данные
post '/visit' do
  @users = Client.new params[:client]
  if @users.save
    erb "<h2>Вы записались</h2>"
  else
    @error = @users.errors.full_messages.first
    erb :visit
  end
end
