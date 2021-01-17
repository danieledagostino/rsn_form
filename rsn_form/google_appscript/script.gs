function doPost(request){
  // Open Google Sheet using ID
  //var sheet = SpreadsheetApp.openById("14r2DK3rPxOnRyWqgq8xXx57k3HAXdE3WnOHOm7e6Sy4").getSheetByName('results');
  var ss = SpreadsheetApp.getActiveSpreadsheet();
  var sheet = ss.getSheets()[0];
  var result = {"status": "SUCCESS"};
  //MailApp.sendEmail('danieledagostino81@gmail.com','TEST doPost()',JSON.stringify(request));
  var jsonData = JSON.parse(request.postData.contents);
  try{
    // Get all Parameters
    var p = [];
   Object.keys(jsonData).forEach(function(k) {
      p.push(jsonData[k]['value']);
   });

    // Append data on Google Sheet
    Logger.log(p);
    var rowData = sheet.appendRow(p);
    SpreadsheetApp.flush();
    return redirect();

  }catch(exc){
    // If error occurs, throw exception
    result = {"status": "FAILED", "message": exc};
    return ContentService
      .createTextOutput(JSON.stringify(jsonData) +"\n"+exc)
      .setMimeType(ContentService.MimeType.JSON);
  }

  
}

function redirect() {
  return HtmlService.createHtmlOutput(
    "<script>window.top.location.href=\"www.google.it\";</script>"
  ); 
}
