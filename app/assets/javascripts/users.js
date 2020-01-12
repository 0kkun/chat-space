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

  // ユーザー削除ボタンをクリックしたら発火するhtml
  function addDeleteUser(name, id) {
    let html = `
    <div class="chat-group-user clearfix" id="${id}">
      <p class="chat-group-user__name">${name}</p>
      <div class="user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn" data-user-id="${id}" data-user-name="${name}">削除</div>
    </div>`;
    $(".js-add-user").append(html);
  }
  // ユーザー追加ボタンをクリックしたら発火するhtml
  function addMember(userId) {
    let html = `<input value="${userId}" name="group[user_ids][]" type="hidden" id="group_user_ids_${userId}" />`;
    $(`#${userId}`).append(html);
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
  //------------------------追加削除ボタンで発火するjs--------------------------
  // $(document).onすることで常に最新のHTMLの情報を取得することができる
  // Ajax通信で作成されたHTMLの情報を取得している
  $(document).on("click", ".chat-group-user__btn--add", function() {
    console.log
    // 追加ボタンの対象であるユーザー情報を変数へ代入し、HTMLを描画
    const userName = $(this).attr("data-user-name");
    const userId = $(this).attr("data-user-id");
    $(this)
      .parent()
      .remove();
    addDeleteUser(userName, userId);
    // ユーザーの追加や削除の情報は addMemberメソッドを作成してコントロール
    // メンバーを追加する際に情報をuser_idsへ追加できるような仕組みを作り、
    // 削除ボタンを押すと同時にその情報も削除
    addMember(userId);
  });
  $(document).on("click", ".chat-group-user__btn--remove", function() {
    $(this)
      .parent()
      .remove();
  });
});