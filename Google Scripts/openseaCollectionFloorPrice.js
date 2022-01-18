/**************************************************
 * 
 * Opesea.io
 * This script parses `floor_parse` from opensea
 * using the api (as free and anonymous user)
 * with collection `slug` or URL
 * and saves to the CELL from it was called.
 * 
 * This script exposes a custom function named
 * `getFloorPrice` that processes the data.
 * 
 * Author: Rakibul Yeasin <ryeasin03@gmail.com>
 * 
 *************************************************/

// Request Header to tell opensea to response as JSON
const option = {
  headers : {
    "Accept": "application/json"
  }
};

/*
 * Requests to opensea api and parses the floor price of a `Collection` 
 * @params {String} collection
 * @return {String} floorPrice
 */
function getFloorPrice(collection) {
  // Throw ERROR if collection is empty
  if (collection === '') {
    return "Please Specify a collection slug/url.";
  }

  const urlChecker= /http?s:\/\//gm
  let isUrl = urlChecker.test(collection);
  if (isUrl) {
    /*
     * As we only need the collection `slug`
     * So just splitted the `slug` from url
     */
    collection = parseCollection(collection);
  }

  // API endpoint to get asset stats
  let url = `https://api.opensea.io/api/v1/collection/${collection}/stats`;
  let response = UrlFetchApp.fetch(url, option).getContentText();
  response = JSON.parse(response);

  // The Floor Price
  let floorPrice = response?.stats?.floor_price;
  
  /*
   * Some collections doesn't have the floor price param
   * So they aren't for sale yet!
   */
  if (floorPrice === null) {
    return "This collection isn't on sale."
  }
  
  return floorPrice
}

/*
 * Parses opesea url to collection `slug`
 * @params {String} url
 * @return {String} slug
 */
function parseCollection(url) {
  let theUrlArray = url.split('/');
  // Final Slug
  let slug = theUrlArray[theUrlArray.length - 1];
  return slug
}

// Testing Log
Logger.log(getFloorPrice('https://opensea.io/collection/the-sandbox-mega-city-land-sale-2'))
