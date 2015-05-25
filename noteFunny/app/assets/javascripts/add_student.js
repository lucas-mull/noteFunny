function checkAllCbs(caller){
	var allInputs = document.getElementsByTagName("input");
	for (var i = 0, max = allInputs.length; i < max; i++){
	    if (allInputs[i].type === 'checkbox'){
	        allInputs[i].checked = caller.checked;
	    }
	}
}
