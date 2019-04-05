/*
 * Not Yet Completed
 */


function private() {
	var privacy = document.querySelectorAll('[aria-label="Shared with Public"]');
    /*for(i = 0; i < i.length; i++) {
        privacy[i].click();
    }*/
	privacy[0].click();
	var onlyMe = document.getElementsByClassName('_54nc _54nu _48t_');
	onlyMe[0].click();
	if(onlyMe[0].innerText == 'Only me') onlyMe.click();
}
