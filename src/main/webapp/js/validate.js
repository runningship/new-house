function checkNotnullInput(){
	var valid=true;
	$('input[not-null=true]').each(function(index,obj){
		if($(obj).val()==''){
			$(obj).css('border' , 'solid 1px red');
			valid = false;
		}
	});
	return valid;
}
