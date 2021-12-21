resource "aws_instance" "zenqms" {
  ami           =  var.ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = [var.security_group]
  key_name = var.key
  count         = var.instance_count

  tags = {
    Name = element(var.name, count.index)
    Environment = "${var.environment}"
  }
}

resource "null_resource" "ansible-provision"{
  count = "${var.instance_count}"
  provisioner "remote-exec" {
    inline = ["echo 'Wait, Until SSH is Ready'"]
    connection {
      type = "ssh"
      user = var.ssh_user
      private_key = file(var.private_key_path)
      host = element(aws_instance.zenqms.*.public_ip, count.index+1)
    }
  }
  provisioner "local-exec" {
    command = "ansible-playbook -i ${element(aws_instance.zenqms.*.public_ip, count.index+1)}, --private-key ${var.private_key_path} setup.yml"
  }
}
