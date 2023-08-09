# frozen_string_literal: true 
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}

class Client < ActiveRecord::Base
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
  erb :visit
end

# Отправить данные
post '/visit' do
  users = Client.new
  users.name = params[:name]
  users.phone = params[:phone_number]
  users.date_stamp = params[:date_time]
  users.barber = params[:barber]
  users.color = params[:color]
  users.save

  erb :visit
end
