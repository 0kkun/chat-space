$(function() {

  // --------------------------関数の定義------------------------------------
  //${} を使用する事でテンプレートリテラル内で式展開が可能
  // appendメソッド を使用してHTMLを描画
  function addUser(user) {
    let html = `
      <div class="chat-group-user clearfix">
        <p class="chat-group-user__name">${user.name}</p>
        <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${user.id}" data-user-name="${user.name}">追加</div>
      </div>
    `;
    $("#user-search-result").append(html);
  }

  function addNoUser() {
    let html = `
      <div class="chat-group-user clearfix">
        <p class="chat-group-user__name">ユーザーが見つかりません</p>
      </div>
    `;
    $("#user-search-result").append(html);
  }

  // --------------------------実際の処理------------------------------------

  //user-search-fieldにユーザーが何か入力したら発火
  $("#user-search-field").on("keyup", function() {
    // ユーザーサーチフィールドに入力された文字をinputに代入
    let input = $("#user-search-field").val();
    // console.log(input); // 正しく格納できているかコンソールでチェック

    // 非同期通信でusersコントローラへ通信リクエストする
    // indexアクション実行をリクエストしている
    // jbuilderで指定したvalueをjson形式で受け取っている
    // コントローラにinputを送っている
    // 値(input)を含むデータをDBから取得するようにコントローラで処理する
    $.ajax({
      type: "GET",
      url: "/users", ////users_controllerのindexアクションにリクエストの送信先を設定する
      data: { keyword: input },
      dataType: "json"
    })
      .done(function(users) {
        // console.log("成功です");

        //emptyメソッドで一度検索結果を空にする
        $("#user-search-result").empty();

        //usersが空かどうかで条件分岐
        if (users.length !== 0) {
          //配列オブジェクト１つ１つに対する処理
          users.forEach(function(user) {
            addUser(user);
          });
        } else if (input.length == 0) {
          return false;
        } else {
          addNoUser();
        }

      })
      .fail(function() {
        // console.log("失敗です");
        alert("通信エラーです。ユーザーが表示できません。");
      });
  });
});