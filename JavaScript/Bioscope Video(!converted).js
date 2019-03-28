function getBioUrl() {
  var regex = /https:\/\/vod+([\w.,@?^=%&:/~+#-]*)?/g;
  var html = document.body;
  var url = regex.exec(html.textContent);
  return url[0];
};
