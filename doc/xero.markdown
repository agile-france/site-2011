SetUp
=====

enable app to connect on xero
-----------------------------
generate x509 certificate on xero

    openssl req -newkey rsa:1024 -x509 -key xero.rsa -out xero.cer -days 3650

upload xero.cer into https://api.xero.com/Application/Add


Bugs
====
http://answers.xero.com/developer/question/24421/ : private app can not post and invoice... use put instead


