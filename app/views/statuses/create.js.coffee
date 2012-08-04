$("#spinner").hide();
$('#status_input_box').val('').focus();
$('#counter_box').text('140');

setbuttonclick();

$('#statuses').prepend('
<div class="container-fluid">

<div id="temp">
	<div class="row-fluid well">
	<div class="span2">
	<% if session["image"] %>	
	<img src="<%= session["image"] rescue "" %>" style="width:75px; height: 75px;" align="left"/>
	<% else %>
	<%= gravatar_image_tag session["email"], :class => "gravatar", :align => "left", :style => "width:75px; height: 75px;" rescue "" %>
	<% end %>
	
	</div>

	<div class="span10">
		<div class="row-fluid">
		<div class="span10">

		<p> 
			 Status Update: <%=@status.message.gsub("'", "") rescue "" %>
		</p>

		</div>
		</div>
		<div class="row-fluid">
		<div class="span10">

		<a href="/<%= session["username"] rescue ""%>">
		<%= session["username"].upcase rescue ""%></a> 
		Updated <%= time_ago_in_words @status.created_at rescue ""%> ago

	</div>
	</div>
	</div>

</div>
</div>
</div>
') 
.hide()
.fadeIn()




