- in terraform there are 2 types of provisioners
    - create time provisioner
    - destroy time provisioner
    ` provisioner "local-exec" {
    when    = destroy
    command = "echo 'Destroy-time provisioner'"
  }`
- if a provisioner failes because of any issue, then the resource is marked as tainted, so when you fire "terraform apply" the existing resource is destroyed and a new one is created.
- if we want to take a decision path on failure we have "on_failure" attribute in provisioners
<li> If we want to continue on failure below is the code </li>
   ` provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install -y nginx1.12",
      "sudo systemctl start nginx"
    ]
     on_failure = continue
  }`