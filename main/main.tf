provider "aws" {
    region = var.region
    profile = var.profile
}

module "instance" {
    source = "../module/instance"
    subnet_id = "subnet-8821e4b9"
    security_group = "sg-037c5e7dccb4741d0"
    ami = "ami-0ed9277fb7eb570c9"
    instance_type = "t2.micro"
    environment = "devlopment"
    name = ["adarsh","zenqms","test"]
    instance_count = "3"
    key = "iAdarsh"
    ssh_user = "ec2-user"
    private_key_path = "~/Downloads/iAdarsh.pem"
}



