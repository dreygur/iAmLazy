/*
  * SMS Sender Using api
  * Author: Rakibul Yeasin
  * To Compile: gcc sms.c -o sms -l curl
  */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <curl/curl.h>

int main(int argc, const char **argv) {
  // Initializing CURL
  CURL* curl = curl_easy_init();
  CURLcode res = CURLE_OK;

  // Exit if No argument passed
  if(argc < 2) {
    fprintf(stderr, "Please Write your Message and Phone number\n");
    return 1;
  }

  // API Base-Domain
  char api[] = "http://esms.dianahost.com/smsapi?api_key=";
  // API Key
  char api_key[] = ""; // Your API_KEY
  char url[600];
  // Message
  char *message;
  // SenderID
  char senderID[] = ""; //SENDER_ID

  if(argc >= 3) {
    message = curl_easy_escape(curl, argv[2], 0);
    snprintf(url, sizeof(url), "%s%s&contacts=88%s&msg=%s&senderid=%s&type=text", api, api_key, argv[1], message, senderID);
    curl_free(message);
  }

  // Checking if the user is finding or need Help
  if(argc < 3 && (strcmp(argv[1], "help") || strcmp(argv[1], "h"))) {
    fprintf(stdout, "\n"
      "HELP: use help or h to view this help message.\n"
      "To send a message \"PHONE_NUMBER\" \"YOUR_MESSAGE\"\n\n"
      );
    return 2;
  }

  // Exit if CURL is not initialized
  if(!curl) {
    fprintf(stderr, "CURL initialization failed!");
    return 128;
  }

  // Opening Request
  if((res = curl_easy_setopt(curl, CURLOPT_URL, url)) != CURLE_OK) {
    fprintf(stderr, curl_easy_strerror(res));
    return 1;
  }

  // If the url redirects then follow the new link
  if((res = curl_easy_setopt(curl, CURLOPT_FOLLOWLOCATION, 1L)) != CURLE_OK) {
    fprintf(stderr, curl_easy_strerror(res));
    return 1;
  }

  // Send the Request
  if((res = curl_easy_perform(curl)) != CURLE_OK) {
    fprintf(stderr, curl_easy_strerror(res));
    return 1;
  }

  // Close CURL
  curl_easy_cleanup(curl);

  return 0;
}
