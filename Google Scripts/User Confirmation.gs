// Google Sheet Selector Object
var sheet = SpreadsheetApp.getActiveSheet();

function sendSms(name, contacts) {
  // Message Text
  var message = "Hello " + name + ", Thanks for the response. We have recieved your details. If you have more query feel free to call us at: XXXXXXXXXXX";
  // HTTP Request type
  var options = {
    "method" : "GET"
  };
  // API url
  var smsUrl = "http://esms.dianahost.com/smsapi?api_key=XXXXXXXXXXX&contacts=88"
               + contacts + "&msg=" + message + "&senderid=XXXXXXXXXXXX&type=text";
  
  try {
    // Sending Request
    var data = UrlFetchApp.fetch(encodeURI(smsUrl), options);
  } catch(err) {
    // Error Logger
    Logger.log(err);
  }
}

function SEND() {
  // Get all the values from sheet
  var data = sheet.getDataRange().getValues();
  
  for (i = 1; i <= data.length; i++) {
    // Setting break-point for blank fields
    if(data[i] === undefined) break;
    // get current row from data object
    var row = data[i];
    var name = row[1];
    var number = row[2];
    var status = row[4];
    if (status != 'sent') {
      // triiger sms function
      sendSms(name, number);
      // SpreadsheetApp.flush();
      // Set flag to sent
      sheet.getRange(i+1, 5).setValue('sent');
    }
  }
}

// Test Function to check if the api is working oe not
function test(){
  sendSms("Rakibul Yeasin", "XXXXXXXXX");
}
