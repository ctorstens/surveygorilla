$(document).ready(function() {
  $('div.survey').on('click','a#add_question',function(e){
    e.preventDefault();
    $('.survey-question-mcq-widget').clone().removeClass('survey-question-mcq-widget').addClass('survey-question-mcq').hide().appendTo('.widget-container').slideToggle('fast');
  });
});


