function openLoad() {
  var id = document.getElementById('lqEH1').innerHTML;
  var url = 'https://openload.co/stream/' + id + '?mime=true';
  window.open(url);
}

openLoad();
