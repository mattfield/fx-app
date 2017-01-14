$('.convert').on('click', function(e){
  var amount = $('#inputAmount').val(),
      date = $('#inputDate').val(),
      from = $('#inputFrom').val(),
      to = $('#inputTo').val(),
      resultField = $('.result-field');

  $('.amount').text(amount);
  $('.from_curr').text(from);
  $('.to_curr').text(to);

  var handle = function(data, status, xhr){
    $('.result').text(data);
    resultField.show();
  };

  $.ajax("/convert?date=" + date + "&amount=" + amount + '&to=' + to + '&from=' + from).done(handle);
});
