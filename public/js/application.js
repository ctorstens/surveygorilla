$(document).ready(function() {
    $('button#copy-button').zclip({
        path:'/js/ZeroClipboard.swf',
        copy:('fasf')
    });



  $('form').on('submit',function(){
    var numOfQuestions= $('div.widget-container').children().length;
    for (var i=0; i<numOfQuestions; i++) {
      $('div.widget-container').children().eq(i).find('.survey-question-position').val((i+1));
    }
  });

  $("#survey-date-picker").datepicker();

  $(function() {
    $( ".widget-container" ).sortable();
    $( ".widget-container" ).disableSelection();
  });

  $('div.survey').on('click', ".selected > .survey-question-remove",function(){
    $(this).parent().fadeOut('fast', function(){
      $(this).remove();
    });
  });

  $('div.survey').on('click',".widget", function(){
    unselectAll('div.survey .widget');
    selectAll(this);
    hideFirstShowSecond('div.survey .unselected.widget #add-choice','div.survey .selected.widget #add-choice');
  });

  $('div.survey').on('click','button#add_question',function(e){
    e.preventDefault();
    unselectAll('div.survey .widget');
    hideFirstShowSecond('div.survey .unselected.widget #add-choice','div.survey .selected.widget #add-choice');
    addItemTo('#survey-inventory > .survey-question','.widget-container');
  });

  $('div.survey').on('click','button#add-choice',function(e){
    e.preventDefault();
    addItemTo('#survey-inventory > .survey-question-mcq-q','.widget-container .selected.survey-question ol');
  });

  $('div.survey').on('change','.survey-question-type', function(){
    if ($(this).val() == "MultipleChoice") {
      findSelectorFindCloestFindChildrenReplaceWith(this,'div.widget', '.survey-question-choices', '#survey-inventory > .mcq-widget');
    }else{
      findSelectorFindCloestFindChildrenReplaceWith(this,'div.widget', '.survey-question-choices', '#survey-inventory > .tq-widget');
    }
  });

  $("input[name=submit-visitor]").on('click', function(e){
    e.preventDefault();
    $(".modal-popup").modal({onClose: function() {
      $('.modal-container').remove();
      $.modal.close();
    }});
  });

  $('.signin-visitor').on('submit', function(e){
    e.preventDefault();
    $.ajax({
      url: '/signin',
      type: "get",
      data: $(this).serialize()}).done(function(){
        $.ajax({
          type: "post",
          data: $('form.view-survey-form').serialize(),
          url: $("form.view-survey-form").attr('action')
        }).done(function(){
          $.modal.close();
          location.reload();
        });
      });
    });

  $('form.signup-visitor').on('submit', function(e){
    e.preventDefault();
    $.ajax({
      url: '/signup',
      type: 'post',
      data: $(this).serialize()
    }).done(function (){
      $.ajax({
        type: 'post',
        url: $('form.view-survey-form').attr('action'), 
        data: $('form.view-survey-form').serialize()
      }).done(function (){
        $.modal.close();
        location.reload();
      });
    });
  });


});



function findSelectorFindCloestFindChildrenReplaceWith(selector, cloestParent, childSelector,replaceWith){
  $(selector).closest(cloestParent).children(childSelector).replaceWith($(replaceWith).clone());
}

function addItemTo(inventory, appendTo) {
  $(inventory).clone().hide().appendTo(appendTo).slideToggle('fast');
}

function unselectAll(selector){
  $(selector).removeClass('selected').addClass('unselected');
}
function selectAll(selector){
  $(selector).removeClass('unselected').addClass('selected');
}

function hideFirstShowSecond(hideSelector,showSelector){
  hideFast(hideSelector);
  showFast(showSelector);
}

// Example


function hideFast(selector){
  $(selector).hide();
}


function showFast(selector){
  $(selector).show();
}
