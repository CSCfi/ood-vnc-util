$(function () {
  const partition_select = $("#batch_connect_session_context_csc_slurm_partition");
  partition_select.change(update_app_select);
  update_app_select();
});

function update_app_select() {
  const partition_select = $("#batch_connect_session_context_csc_slurm_partition");
  const app_select = $("#batch_connect_session_context_app");
  const hide = app_select.find('option:not(:disabled)').length <= 1;
  app_select.closest(".form-group").toggleClass("d-none", hide);
}

