# CoolPay Integration

![Screenshot](/screenshots/app_screenshot.png)

## Setup/Run
* Clone repo and go to root of project folder.
* Run `bundle install` to install required gems.
* Create `.env` file in root directory and add your API credentials:
```
USERNAME = "USERNAME"
API_KEY = "API_KEY"
```
* Run `rackup`.
* Go to localhost:9292 and £££.

## Technologies Used

* Ruby
* Sinatra
* RSpec 
* Bootstrap

## Tests

Run `rspec` to run the unit and feature tests. Feature testing is nowhere close to as thorough as it needs to be due to time constraints.

## User Stories

```
- Authenticate to Coolpay API
- Add recipients
- Send them money
- Check whether a payment was successful
```

## Pending
* Stub the API in testing to prevent real calls when running `rspec`.
* Greater feature test coverage.
* Extracting `app.rb` into separate controllers.
* Adding currency options for user to select.
* Deploy app to Heroku or AWS.
