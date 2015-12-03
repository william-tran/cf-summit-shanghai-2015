# Enabling Cloud Native Security with Multi-Tenant UAA 


## Slides: 
http://www.slideshare.net/WillTran1/enabling-cloud-native-security-with-oauth2-and-multitenant-uaa

## Demo:

1. Add myzone.localhost to your hosts file
  
   ```
sudo sh -c 'echo "127.0.0.1 myzone.localhost" >> /etc/hosts'
   ```

1. Make sure nothing is running on port 8080, then start up UAA with the Maven Cargo plugin

   ```
cd uaa
mvn cargo:run
   ```

1. In a new shell in the /uaa subfolder, create the new Identity Zone, clients and users

   ```
. create-zone.sh
   ```

1. Make sure nothing is running on port 8081, then run the demo app

   ```
cd ../sales-app
mvn spring-boot:run
   ``` 

1. Go to http://localhost:8081 and log in with username salesguy, password password
