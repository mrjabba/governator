$(function() {
  $('#group_user_tokens').tokenInput("/users.json", {
    crossDomain: false,
    prePopulate: $('#group_user_tokens').data("pre"), 
    theme: "facebook"
  });
});
