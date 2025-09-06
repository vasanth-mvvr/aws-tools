module "jenkins" {
    source = "terraform-aws-modules/ec2-instance/aws"
    name = "jenkins"
    instance_type = "t2.micro"
    vpc_security_group_ids = []
    subnet_id = ""
    user_data = file("master.sh")
    ami = data.aws_ami.ami_info.id
    tags = merge(
        var.common_tags,
        {
            Name = "${var.project_name}"
        }
    )
}
module "jenkins-agent" {
    source = "terraform-aws-modules/ec2-instance/aws"
    name = "jenkins-node"
    instance_type = "t2.micro"
    vpc_security_group_ids = []
    subnet_id = ""
    user_data = file("master-agent.sh")
    ami = data.aws_ami.ami_info.id
    tags = merge(
        var.common_tags,
        {
            Name = "${var.project_name}"
        }
    )
}
resource "aws_key_pair" "tools" {
  key_name = "tools"
  public_key = file("~/.ssh/tools.pub")
}

module "nexus" {
  source = "terraform-aws-modules/ec2-instance/aws"
  instance_type = "t2.micro"
  key_name = aws_key_pair.tools.key_name
  vpc_security_group_ids = []
  subnet_id = ""
  ami = data.aws_ami.ami_info.id
  root_block_device = [
    {
        volume_type = "gp3"
        volume_size = 30
    }
  ]
  tags = merge(
    var.common_tags,
    {
        Name = "Nexus"
    }
  )
}

module "records" {
    source = "terraform-aws-modules/route53/aws//modules/records"
    version = "~> 2.0"

    zone_name = var.zone_name

    records = [
    {
        name = "jenkins"
        type = "A"
        ttl = 1
        records = [
            module.jenkins.public_ip
        ]
    },
    {
        name = "jenkins-agent"
        type = "A"
        ttl = 1
        records = [
            module.jenkins-agent.private_ip
        ]
    },
        {
        name = "nexus"
        type = "A"
        ttl = 1
        over_write = true
        records = [
            module.nexus.private_ip
        ]
    }
    
  ]
}