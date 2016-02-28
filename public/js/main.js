$(document).ready(function(){

  $('.modal-link').click(function(e){
    $('#outer-box').show();
  });

  $('#submit').click(function(){
    $('#outer-box').hide();
  });

  $('#cancel').click(function(){
    $('#outer-box').hide();
  });

});
