
# setup hostname myzone.localhost in /etc/hosts
# target my local uaa
uaac target http://localhost:8080/uaa
# get a token as the identity client
uaac token client get identity -s identitysecret
# see the token contains zones.write
uaac token decode
# create an identity zone. no UAAC commands for this so use uaac curl, which is like curl but it adds the token header
uaac curl /identity-zones -X POST -H "Content-type:application/json" -d '{"id":"12345","subdomain":"myzone","name":"My Identity Zone"}'
# make marissa the zone admin. You need to be admin to do this
uaac token client get admin -s adminsecret
uaac group add zones.12345.admin
uaac member add zones.12345.admin marissa

# get a token as marissa with the zone admin scope. Use the authcode grant and the identity client
uaac token authcode get -c identity -s identitysecret --scope zones.12345.admin
# see the token contains zones.12345.admin
uaac token decode

# create an admin client in the zone. The authorities are the same authorities as the admin in the UAA zone.
uaac curl /oauth/clients -H "Content-type:application/json" -H "X-Identity-Zone-Id:12345" -X POST -d '{"client_id":"admin","client_secret":"zonesecret","scope":["uaa.none"],"resource_ids":["none"],"authorities":["uaa.admin","clients.read","clients.write","scim.read","scim.write","clients.secret"],"authorized_grant_types":["client_credentials"]}'

# doing things as a zone admin via uaac is cumbersome because we can't reuse the cli commands, 
# we have to use uaac curl to include the zone id header.
# But we've just created an admin client in the zone, so lets use that to do everything else

# target the new zone with its subdomain
uaac target http://myzone.localhost:8080/uaa
# get a token as the admin in the zone
uaac token client get admin -s zonesecret
# now we can do whatever we want
# create salesguy for that first example
uaac user add salesguy --email salesguy@acme.com -p password
# create clients with any authorities for the second example
uaac client add sales-app -s secret --authorities uaa.resource --scope openid --authorized_grant_types authorization_code

