- create a key-pair from the EC2 dashboard and download that key-pain (.pem) file
- remote-exec is used to connect to remote EC2 instance once the instance is created
- before you actually run the remote-exec make sure you have changed the .pem file permissions by running
chmod 400 *.pem
- once the terraform created the infrastructure it will apply default security group, so make sure righ set of rules are kept to allow traffic for SSH and web so that traffic can flow into the instance.
