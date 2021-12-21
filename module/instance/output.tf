output "public_ip" {
    value = "${join(",", aws_instance.zenqms.*.public_ip)}"
}