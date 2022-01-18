function getFloorPrice(collection) {
  var option = {
    headers : {
      "Accept": "application/json"
    }
  };

  var url = `https://api.opensea.io/api/v1/collection/${collection}/stats`;
  var response = UrlFetchApp.fetch(url, option).getContentText();
  response = JSON.parse(response);

  Logger.log(response?.stats?.floor_price);
  return response?.stats?.floor_price;
}
