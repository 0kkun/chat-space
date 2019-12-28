# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|email|string|null: false|
|password|string|null: false|
### Association
- has_many :massages
- has_many :groups

## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|body|text|null: false|
|image|string||
|user_id|integer|null: false|
|group_id|integer|null: false|
|timestamps|||
### Association
- belog_to :users
- belong_to :group_messages

## groupsテーブル
|Column|Type|Options|
|------|----|-------|
|group_name|text|null: false|
|timestamps|||
### Association
- belog_to :users
- has_many :group_messages
- has_many :members

## group_messagesテーブル
|Column|Type|Options|
|------|----|-------|
|message_id|integer|null: false|
|group_id|integer|null: false|
### Association
- belog_to :messages
- belong_to :groups

## membersテーブル
|Column|Type|Options|
|------|----|-------|
|member_name|text|null: false|
### Association
- belong_to :groups


* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
