# README

# About this application
### 名称
- Chat space

### 概要
- メンバーを指定してグループを作成し、コメント及び画像を投稿してチャットをすることができる

### 本番環境
- デプロイ先：AWS
- http://3.114.127.24/
- ID : test@gmail.com / PASS : 11111111

### 制作背景(意図)
- Tech::Expertのカリキュラムで、Ruby on Railsを使ったアプリケーション開発を練習するため

### 使用技術
- Ruby on Rails 5.2.4.1
- ruby 2.5.1p57
- MySQL 5.6.46 Homebrew
- jQuery
- AWS
- haml
- sass

## DB設計

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false|
### Association
- has_many :messages
- has_many :groups, through: :group_users
- has_many :group_users

## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|content|string||
|image|string||
|user_id|integer|null: false|
|group_id|integer|null: false|
### Association
- belog_to :users
- belong_to :groups

## groupsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
### Association
- has_many :users, through: :group_users
- has_many :messages
- has_many :group_users

## group_usersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :group
- belongs_to :user

