// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
async function get_markdown(raw) {
  let request_body = { content: raw };

  let response = await fetch('/markdown', {
    method: 'post',
    headers: {
      "Content-Type": "application/json",
      "Accept": "application/json"
    },
    body: JSON.stringify(request_body)
  });
  return await response.text();
}

function update_markdown(source_id = 'wiki-content', target_id = 'wiki-preview') {
  const raw_markdown_el = document.getElementById(source_id)
  const preview_el = document.getElementById(target_id)
  get_markdown(raw_markdown_el.textContent)
    .then((data) => {
      preview_el.innerHTML = data;
    });
}


function reset_preview(element_id = 'wiki-preview') {
  const preview_el = document.getElementById(element_id)
  preview_el.innerHTML = '<div class="loading"><div></div></div>';
}
