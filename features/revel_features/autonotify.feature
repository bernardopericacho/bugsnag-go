Feature: Using auto notify

Background:
  Given I set environment variable "API_KEY" to "a35a2a72bd230ac0aa0f52715bbdc6aa"
  And I configure the bugsnag endpoint
  And I set environment variable "SERVER_PORT" to "4515"

Scenario: An error report is sent when an unhandled crash occurs
  Given I set environment variable "AUTO_CAPTURE_SESSIONS" to "false"
  When I start the service "revel"
  And I wait for the app to open port "4515"
  And I wait for 4 seconds
  And I open the URL "http://localhost:4515/unhandled"
  Then I wait to receive a request
  And the request is a valid error report with api key "a35a2a72bd230ac0aa0f52715bbdc6aa"
  And the event "unhandled" is true
  And the exception "errorClass" equals "*runtime.TypeAssertionError"
  And the exception "message" matches "interface conversion: interface ({} )?is struct {}, not string"

Scenario: An error report is sent when a go routine crashes which is reported through auto notify
  Given I set environment variable "AUTO_CAPTURE_SESSIONS" to "false"
  When I start the service "revel"
  And I wait for the app to open port "4515"
  And I wait for 4 seconds
  And I open the URL "http://localhost:4515/autonotify"
  Then I wait to receive a request
  And the request is a valid error report with api key "a35a2a72bd230ac0aa0f52715bbdc6aa"
  And the event "unhandled" is true
  And the exception "errorClass" equals "*errors.errorString"
  And the exception "message" equals "Go routine killed with auto notify"
