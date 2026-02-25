client --> ALB --> ACM --> TARGET GRP -> PODS

# Till here, the Application Load Balancer (ALB) is created with a listener
# on the default port (80/443) and default actions.
#
# AWS automatically assigns a default DNS name to the ALB, for example:
# roboshop-frontend-alb-123456.ap-south-1.elb.amazonaws.com
#
# This DNS name is owned by AWS. To use our custom domain, we create a
# CNAME (or Alias) record in Route 53:
# roboshop-dev.vigi-devops.com  -->  ALB DNS name
#
# After this, any request to roboshop-dev.vigi-devops.com reaches
# the frontend Application Load Balancer.
#
# The ALB has an ACM SSL certificate attached to its HTTPS listener.
# During the TLS handshake:
# 1. The ALB sends its SSL certificate to the client (browser).
# 2. The certificate contains the public key and is signed by a trusted CA.
# 3. The browser validates the certificate using its built-in CA store.
#
# Once the certificate is trusted:
# 4. The browser generates a symmetric session key.
# 5. The session key is encrypted using the public key from the certificate.
# 6. The encrypted session key is sent back to the ALB.
# 7. The ALB decrypts it using the private key.
#
# From this point onward:
# - Both the browser and the ALB use the shared session key
# - All HTTP data is encrypted using fast symmetric encryption
#
# Finally, the encrypted request is forwarded from the ALB
# to the frontend target group.


FINAL VERSION:::::::::::::::::::::: READ BELOW IMP

Step 1: TLS handshake (key exchange)

Browser connects to your ALB (HTTPS)

ALB sends certificate

Contains public key

Browser:

Validates certificate using trusted CA

Generates a random symmetric session key

Browser encrypts only the session key using:

✅ ALB’s public key

Encrypted session key is sent to ALB

ALB decrypts it using:

✅ ALB’s private key

👉 Now both browser and ALB share the same session key

Step 2: Actual data transfer (your “hello how r u”)

Now comes your message 👇

hello how r u

✔ Browser encrypts this using the session key (symmetric encryption like AES)
✔ ALB decrypts it using the same session key