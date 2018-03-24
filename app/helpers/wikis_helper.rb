module WikisHelper
  
  def allowed_to_edit_wiki(wiki)
    signed_in? && allowed_to_view_wiki(wiki)
  end
  
  def allowed_to_view_wiki(wiki)
    !@wiki.private || current_user == @wiki.user
  end
end
