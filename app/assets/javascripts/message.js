$(function() {

  //form_forで作成したフォームには、#new_messageと言うidがデフォルトでついている
  $('#new_message').on('submit', function(e) {
    e.preventDefault(); //デフォルトのイベントを止める
    var message = $('.input-form__text').val();
    console.log(message);
  });
});