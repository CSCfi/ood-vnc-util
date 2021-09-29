$(document).ready(function () {
  const desktop_environment_input = $("#batch_connect_session_context_desktop");
  desktop_environment_input.change(update_app_input);
  update_app_input();
});

function update_app_input() {
  const desktop_environment_input = $("#batch_connect_session_context_desktop");
  const app_input = $("#batch_connect_session_context_app");
  
  if (desktop_environment_input.val() === "") {
    app_input.parent().show();
  } else {
    app_input.parent().hide();
    app_input.val("");
  }
}
