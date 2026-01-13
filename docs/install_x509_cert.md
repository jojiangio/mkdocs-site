
=======================================
Installing a CA-signed x509 certificate
=======================================

---------------------------------
Step 1: Request cert from CertHub
---------------------------------

1. Go to CertHub: https://certhub.digitalcerts.identity-services.intranet.ibm.com/
2. Select Request Private TLS/SSL
3. Under Certificate Signing Request (CSR), click Get Command and fill out the required information

Example request command:
 
```
openssl req -new -newkey rsa:2048 \
 -nodes -out httpsg41pzrepoaz1ashcpcibmcom.csr 
 -key out httpsg41pzrepoaz1ashcpcibmcom.key \ 
 -subj "/C=US/ST=Virginia/L=Ashburn/O=International Business Machines Corporation/OU=CIO/CN=https://g41p-z-repo.az1.ash.cpc.ibm.com/"
```

This command creates two files:
- Certificate signing request: https<fqdn>.csr
- Private key: https<fqdn>.key

4. Upload/paste the csr file into the request form

5. Set Certificate Type to Server

6. Obtain IBMInv from: https://w3.ibm.com/standards/system-inventory/

   Search the hostname and copy the IBMInv ID (e.g., 15799e74-91ca-4f73-ade5-a144db8be3bc)

7. Specify at least two owners

8. Submit the request; the certificate will be auto-approved

9. Download leaf, intermediate, and root certificates


-----------------------------------------
Step 2: Install certificate on the server
-----------------------------------------

1. SFTP the certificate files and private key to the server

2. Combine the certificates (leaf + intermediate + root) into one file

```
for _i in orig-files/leaf.cer orig-files/intermediate.cer orig-files/root.cer
  do
    cat "${_i}"
    printf '\n'
  done > combined.cer
```

3. Copy combined cert and private key to appropriate locations

```
sudo cp -i combined.cer /etc/pki/tls/certs/httpd.crt

sudo cp -i g41pzrepoaz1ashcpcibmcom.key /etc/pki/tls/private/httpd.key
```

4. Set file permissions 

```
sudo chmod 444 /etc/pki/tls/certs/httpd.crt

sudo chmod 400 /etc/pki/tls/private/httpd.key
```

5. Update Apache configuration (/etc/httpd/conf.d/ssl.conf)

```
SSLCertificateFile /etc/pki/tls/certs/httpd.crt
SSLCertificateKeyFile /etc/pki/tls/private/httpd.key
```


6. Reload Apache

```
sudo systemctl reload httpd
```

If there are any errors reloading:
* Check Apache logs (journalctl)
* Use `restorecon` on cert and private key if SELinux is enforcing


------------
Verification
------------

Check Apache status: `sudo systemctl status httpd`
Validate certificate: `openssl x509 -in /etc/pki/tls/certs/httpd.crt -text -noout`



