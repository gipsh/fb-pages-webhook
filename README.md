# fb-pages-webhook

This example shows how to use facebook api to get user pages and subscribe 
to the page events. 

I used 
  - koala gem https://github.com/arsduo/koala
  - facebook-messenger gem https://github.com/hyperoslo/facebook-messenger
  

The example is divided in two parts: 

1. We log the user into our facebook app and get user pages 

2. We use facebook messenger to interact with pages conversations. 


## Configuration

### Create an app on facebook

You will need to create a facebook app, and add a webhook to it. 
You want to interact with pages, so select pages as an object when
you create the subscription. 


![alt tag](https://camo.githubusercontent.com/b0760cc847d287667d77c6730e48411a2406da21/68747470733a2f2f73636f6e74656e742d616d74322d312e78782e666263646e2e6e65742f6870686f746f732d786670312f7433392e323137382d362f31323035373134335f3231313131303738323631323530355f3839343138313132395f6e2e706e67)

Dont worry if facebook doesnt let you user the manage_page permision to your app, 
wi will ask for it on the login/auth phase. 



### Config the login 

In your new app also configure the login options,
add as callback url your host: http://localhost:3000 
This makes facebook to go back to your server after auth. 


### Edit config files

Edit `config/facebook.yml` and add you facebook app_id and secret. 
You can also modify here the validation token  

```
development:
  app_id: <%= ENV["FB_APP_ID"] %>
  secret_key: <%= ENV["FB_SECRET"] %>
  validation_token: 38rjdehd93948rf
```



## Try it

run the rails apps

```
rails server 
```


and go to http://localhost:3000/ 


Then log as your facebook user, select the pages you want to 
get conversations and subscribre. 






