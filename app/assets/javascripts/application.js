// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap-sprockets

$(document).ready(function(){


  $('.submit-group').on('click','a.grp-btn',function(event){
    // event.preventDefault()


    var groups = $('ul.list-group')
    var groupArr = {};

    for(var i = 0; i < groups.length; i++){
      var students = groups[i].children;
      var groupIdPhrase = groups[i].getAttribute('id')
      var groupId = groupIdPhrase.substring(6, groupIdPhrase.length)
      var studentsArray = [];
      for(var j = 0; j < students.length; j++){
        var studentIdPhrase = students[j].getAttribute('id');
        var studentId = studentIdPhrase.substring(8, studentIdPhrase.length);
        studentsArray.push(studentId);
      }
      if(studentsArray[0] != undefined){
        groupArr[groupId] = studentsArray;
      }
    }

    var cohortId = $("p#cohort_id").text();

    var groupData = { groupObj: groupArr }

    $.ajax({
      url: "/cohorts/" + cohortId + "/groups/" + 0,
      dataType: "json",
      method: "put",
      data: groupData
    }).done( function(msg) {
      $(".submit-group").addClass("hidden");
      $(".simple_with_drop").removeClass("simple_with_drop");
      $(".alert").removeClass("hidden");
    })

    return false
  })

  $('.table-container').on('click','a.btn',function(event){
    event.preventDefault();
    var url = $(this).closest('td').find('a').attr('href')
    var id = $(this).closest('td').find('a').attr('id')
    var button = $(this).closest('td').find('a')
    var bulb = $(this).closest('tr').find('.bulb-btn')

    //for vote button
    var checkVote = function(){
      if ($(button).hasClass('btn-default')){
          $(button).removeClass('btn-default');
          $(button).addClass('btn-success');
      } else if($(button).hasClass('btn-success')) {
        $(button).removeClass('btn-success')
        $(button).addClass('btn-default');
      }
    }
    var checkBulb = function(){
      if ($(bulb).hasClass('yellow-bulb')){
          $(bulb).removeClass('yellow-bulb');
      } else {
        $(bulb).addClass('yellow-bulb');
      }
    }
    data = {id: id}
    $.ajax({
      url: url,
      method: "GET",
      data: data,
      success: function(data){
        var numRemaining = $(data).find('#num-remaining').text()
        var error = $(data).find('.alert-danger')
        if(error.text().trim() != ""){
          $('.alert-danger').remove()
          $('#remaining-vote-error').append(error)
        } else {
          checkVote()
          checkBulb()
          $('.alert-danger').remove()
        }
        //for remaining vote sign
        var remaining = $(data).find('#remaining-vote').text()
        $('#remaining-vote').html(remaining)
      },
      error: function(data){
      }})
    })

  $("ul.simple_with_drop").sortable({
    group: 'no-drop',
    handle: 'li',
    onDragStart: function ($item, container, _super) {
      // Duplicate items of the no drop area
      if(!container.options.drop)
        $item.clone().insertAfter($item);
        _super($item, container);
    }
  });

  $('.sorted_table').sortable({
    containerSelector: 'table',
    itemPath: '> tbody',
    itemSelector: 'tr',
    placeholder: '<tr class="placeholder"/>'
  });
})
