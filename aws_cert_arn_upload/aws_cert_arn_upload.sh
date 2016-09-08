#!/usr/sh

openssl genrsa -out my-private-key.pem 2048
openssl req -sha256 -new -key my-private-key.pem -out csr.pem -config openssl.cnf
openssl x509 -req -days 365 -in csr.pem -signkey my-private-key.pem -out my-certificate.pem
openssl rsa -in my-private-key -outform PEM
aws iam upload-server-certificate --server-certificate-name my-server-certificate --certificate-body file://my-certificate.pem --private-key file://my-private-key.pem
aws iam get-server-certificate --server-certificate-name my-server-certificate
