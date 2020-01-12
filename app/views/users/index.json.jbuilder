# javascriptファイルにuserモデルのidカラムとnameカラムの情報をjson形式で渡す。
# javascriptファイルでは、json.id及びjson.nameで呼び出せる
json.array! @users do |user|
  json.id user.id
  json.name user.name
end