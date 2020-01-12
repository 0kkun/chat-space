$(function() {
  
  // ------------------------関数定義----------------------------------
  function buildHTML(message){
    // メッセージに画像が含まれている場合の処理
    if ( message.image ) {
      var html =
       `<div class="message" data-message-id=${message.id}>
          <div class="upper-info">
            <div class="upper-info__talker">
              ${message.user_name}
            </div>
            <div class="upper-info__post-time">
              ${message.created_at}
            </div>
          </div>
          <div class="post-message">
            <p class="post-message__content">
              ${message.content}
            </p>
          </div>
          <img src=${message.image} >
        </div>`
      return html;
      
    // メッセージに画像が含まれていない場合の処理
    } else {
      var html =
       `<div class="message" data-message-id=${message.id}>
          <div class="upper-info">
            <div class="upper-info__talker">
              ${message.user_name}
            </div>
            <div class="upper-info__post-time">
              ${message.created_at}
            </div>
          </div>
          <div class="post-message">
            <p class="post-message__content">
              ${message.content}
            </p>
          </div>
        </div>`
      return html;
    };
  }

  // ------------------------処理----------------------------------

  //form_forで作成したフォームには、#new_messageと言うidがデフォルトでついている
  //フォーム内のsubmitが押されたら、イベントを実行する
  $('#new_message').on('submit', function(e) {
    e.preventDefault(); //デフォルトのイベントを止める

    // var message = $('.input-form__text').val(); //チェック用
    // console.log(message); //チェック用 中身確認用コンソール

    $('.submit-btn').removeAttr('data-disable-with');

    var formData = new FormData(this); // form要素の中身を取得

    // URLパスはフォーム要素のaction属性に格納されている
    // attrでform要素のaction属性の値を指定して取得する
    var url = $(this).attr('action') 

    //messages controllerへcreateアクションをリクエストする
    $.ajax({
      url: url, ///groups/:id番号/messagesが入っている
      type: "POST", //createアクションに対応するHTTPはPOST
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.messages').append(html); //htmlのmessagesクラスに、生成したhtmlを下に追加する。
      // メッセージをスクロールできるようにし、投稿されたら最新のメッセが表示されるところまでスクロールする
      $('.messages').animate({ scrollTop: $('.messages')[0].scrollHeight});
      $('form')[0].reset(); // フォームの中身をリセットする
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
    });
    return false;
  });

// ------------------------チャット自動更新機能-----------------------------------

  var reloadMessages = function() {
    // jQueryのオブジェクトの指定方法 ":last" 
    // .messageというクラスがつけられた全てのノードのうち一番最後のノードを取得
    // つまり、カスタムデータ属性を利用し、ブラウザに表示されている最新メッセージのidを取得
    last_message_id = $('.message:last').data("message-id");
    // console.log(last_message_id); //値取得確認用
    $.ajax({
      //ルーティングで設定した通り/groups/id番号/api/messagesとなるよう文字列を書く
      url: "api/messages",
      //ルーティングで設定した通りhttpメソッドをgetに指定
      type: 'get',
      dataType: 'json',
      //dataオプションでリクエストに値を含める
      data: {id: last_message_id}
    })
    .done(function(messages) {
      // 自動でスクロールされるように、if文でmessageが0件意外の場合は実行するようにする
      if (messages.length !== 0) {
        // console.log('success'); //確認用
        //追加するHTMLの入れ物を作る
        var insertHTML = '';
        //配列messagesの中身一つ一つを取り出し、HTMLに変換したものを入れ物に足し合わせる
        $.each(messages, function(i, message) {
          insertHTML += buildHTML(message)
        });
        //メッセージが入ったHTMLに、入れ物ごと追加
        $('.messages').append(insertHTML);
        //自動スクロール機能を付加。animateを使う。
        $('.messages').animate({ scrollTop: $('.messages')[0].scrollHeight});
        $("#new_message")[0].reset(); //フォームの中身を空にして再度送信できるようにする処理
        $(".form__submit").prop("disabled", false);
      }
    })
    .fail(function() {
      console.log('error');
    });
  };
  // setInterval
  // 第一引数に動かしたい関数名を、第二引数に動かす間隔をミリ秒単位で渡すことができる
  // 7秒毎に処理を繰り返す
  // グループのメッセージ一覧ページを表示している時だけ自動更新が行われるよう処理
  // matchはメソッドを利用した文字列にその正規表現とマッチする部分があれば、
  // それを含む配列を返り値とする
  if (document.location.href.match(/\/groups\/\d+\/messages/)) {
    setInterval(reloadMessages, 7000);
  }

});