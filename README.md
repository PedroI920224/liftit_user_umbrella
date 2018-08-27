# LiftitUserUmbrella

In this document you will find information resume about how to create an user. There are 2 forms by api or render a view with the necesary fields.

## Requirements
This project have the tools to run with **Docker** and **docker-compose -v3**, but too is run this project with the next tools:
* Erlang -v 18 or later
* Elixir -v 1.6.4
* Nodejs -v 9.11.2
* RabbitMQ -v 3.7.7

## Previous background
Some concepts very useful to understand how it runs are:
* API RESTFUL
* TDD

## Configuration

### To update the database run:
 ```bash 
sudo docker-compose run umbrella mix ecto.create
sudo docker-compose run umbrella mix ecto.migrate
sudo docker-compose run umbrella MIX_ENV=test mix ecto.create
sudo docker-compose run umbrella MIX_ENV=test mix ecto.migrate
```

### How to run the test suite
To run the test suite is necessary run:
* ```sudo docker-compose run umbrella mix test```

### Deployment instructions
create user endpoint:

* To create an user use the endpoint _**post /users**_ with the params as follow:
```ruby
  {
    "user":
      { 
         "address": "Av siempre",
         "city": "Springf",
         "confirmed": true,
         "country": "EEUU",
         "email": "el_barto2@outlook.com",
         "name": "Bart2 Simpson",
         "password": "yonofui2",
         "password_hash":"yonofui2",
         "phone_number": "031-123456"
       }
  }
```
this should be return a successfull status code 200 and a response:
```ruby
{
  "id":11,
  "phone_number":"031-123456",
  "name":"Bart2 Simpson",
  "country":"EEUU",
  "address":"Av siempre"
}
```
* With curl:
```ruby
curl -X POST http://localhost:4000/users \
-H 'Content-Type: application/json' \
-d '{"user":{ "address": "Av siempre", "city": "Springf", "confirmed": true, "country": "EEUU", "email": "el_barto2@outlook.com", "name": "Bart2 Simpson", "password": "yonofui2", "password_hash":"yonofui2", "phone_number": "031-123456" }}'
```
* visiting the view:
another way to create an user is visiting **http://localhost:4000/users/new** and fill all the fields


## References
* wait bash service https://github.com/vishnubob/wait-for-it
* Ecto to database https://elixirschool.com/en/lessons/specifics/ecto/
* encrypt password https://github.com/riverrun/comeonin
* rabbitmq like RPC https://www.rabbitmq.com/tutorials/tutorial-six-elixir.html
* testing validation https://medium.com/@diamondgfx/testing-validations-in-elixir-and-ecto-677bd8a071a1
* umbrella projects https://elixir-lang.org/getting-started/mix-otp/dependencies-and-umbrella-projects.html
* remove data-base in test environment http://www.johnpdaigle.com/complexable/2016/03/05/resetting-a-test-database-with-ecto.html
* bootcamp elixir  https://www.udemy.com/the-complete-elixir-and-phoenix-bootcamp-and-tutorial/
