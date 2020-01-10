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
});