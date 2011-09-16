$(function () {
  var form = $('form'),
      container = $('#messages');
      chloe = new Chloe({host: 'localhost', port: 8901});

  chloe.connect(function () {
    chloe.onmessage(function (message) {
      container.prepend("<li>" + message + "</li>");
    });

    form.submit(function () {
      chloe.send(form.serialize());
      $('#message').val('');
      return false;
    });
  });

});
