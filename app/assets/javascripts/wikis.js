// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
function update_markdown(source_selector = '#wiki-content', target_selector = '#wiki-preview') {
  const raw_markdown_el = $(source_selector)
  const preview_el = $(target_selector)
  $.post('/markdown', {
    content: raw_markdown_el.val()
  }).then((data) => {
    preview_el.html(data);
  })
}

function reset_preview(selector = '#wiki-preview') {
  const preview_el = $(selector)
  preview_el.html('<div class="loading"><div></div></div>');
}
