$(function () {
  var form = $('form');
  form.submit(function () {
    $.ajax({
      type: 'post',
      url:  '/message',
      data: form.serialize()
    });
    $('#message').val('');
    return false;
  });

  function fetchMessages() {
    $.getJSON('/updates/' + $('#chat-id').val(),
      function (messages) {
        var i, message,
            container = $('#messages');
        for (i=0; i < messages.length; i++) {
          message = messages[i];
          container.prepend("<li>" + message + "</li>");
        }
      });
  };

  function pollForMessages() {
    fetchMessages();
    setTimeout(pollForMessages, 1000);
  };

  pollForMessages();
});
