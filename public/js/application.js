$(document).ready(function() {
  $('div.survey').on('click',".widget", function(){
    unselectAll('div.survey .widget');
    selectAll(this);
    hideFirstShowSecond('div.survey .unselected.widget .survey-question-choices','div.survey .selected.widget .survey-question-choices');
  });

  $('div.survey').on('click','a#add_question',function(e){
    e.preventDefault();
    unselectAll('div.survey .widget');
    hideFirstShowSecond('div.survey .unselected.widget .survey-question-choices','div.survey .selected.widget .survey-question-choices');
    addItemTo('#survey-inventory > .survey-question-mcq','.widget-container');
  });

  $('div.survey').on('click','a#add-choice',function(e){
    e.preventDefault();
    addItemTo('#survey-inventory > .survey-question-mcq-q','.widget-container .selected.survey-question-mcq ol');
  });

  $('div.survey').on('change','.survey-question-type', function(){
    if ($(this).val() == "MultipleChoice") {
      findSelectorFindCloestFindChildrenReplaceWith(this,'div.widget', '.survey-question-choices', '#survey-inventory > .mcq-widget');
    }else{
      findSelectorFindCloestFindChildrenReplaceWith(this,'div.widget', '.survey-question-choices', '#survey-inventory > .tq-widget');
    }
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

function hideFast(selector){
  $(selector).hide('fast');
}


function showFast(selector){
  $(selector).show('fast');
}
