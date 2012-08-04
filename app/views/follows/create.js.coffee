$("#spinner_<%=@followbutton.to_s%>").hide();

<% if params[:status] == "unfollow" or @unblock or @blocked %>

$('#userstatus_<%=@followbutton.to_s%>').html('<form accept-charset="UTF-8" action="/follows?id=<%=params[:id]%>&amp;status=follow" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="q5PZvleStCQT/W3Et0axfGEUndnHyLFdeouxLN1AKLE=" /></div><div class="btn-group"><button name="button" title="Follow <%=@user.username.upcase%>" type="submit" class="btn" id="follow_<%=@followbutton.to_s%>"><i class="icon-plus"></i> Follow</button><a class="btn dropdown-toggle" data-toggle="dropdown" href="#"><span class="caret"></span></a><ul class="dropdown-menu"><li><a href="/follows/block/<%=@followbutton.to_s%>" data-remote="true">Block <%=@user.username.upcase%></a></li></ul></div></form>');

<% elsif @block %>

$('#userstatus_<%=@followbutton.to_s%>').html('<form accept-charset="UTF-8" action="/follows/unblock/<%=params[:id]%>" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="q5PZvleStCQT/W3Et0axfGEUndnHyLFdeouxLN1AKLE=" /></div><button name="button" title="Unblock <%=@user.username.upcase%>" type="submit" class="btn btn-danger" id="follow_<%=@followbutton.to_s%>"><i class="icon-stop icon-white"></i> Unblock</button></form>');


<% else %>

$('#userstatus_<%=@followbutton.to_s%>').html('<form accept-charset="UTF-8" action="/follows?id=<%=params[:id]%>&amp;status=unfollow" data-remote="true" method="post"><div style="margin:0;padding:0;display:inline"><input name="utf8" type="hidden" value="&#x2713;" /><input name="authenticity_token" type="hidden" value="q5PZvleStCQT/W3Et0axfGEUndnHyLFdeouxLN1AKLE=" /></div><button name="button" title="Unfollow <%=@user.username.upcase%>" type="submit" class="btn btn-danger" id="follow_<%=@followbutton.to_s%>"><i class="icon-remove icon-white"></i> Unfollow</button></form>');

<% end %> 

setbuttonclick(<%=@followbutton.to_s%>);

counter = parseInt($('#followers').text());
<% if params[:status] == "unfollow" %>
$('#followers').text(counter-1);
<% end %>
<% if params[:status] == "follow" %>
$('#followers').text(counter+1);
<% end %>
