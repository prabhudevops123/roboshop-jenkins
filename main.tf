#resource "jenkins_folder" "folders" {
#  name = "Infra"
#}
#
#resource "jenkins_job" "job" {
#  name     = "roboshop"
#  folder   = jenkins_folder.folders.id
#  template = templatefile("${path.module}/sb-job.xml", {
#    description = ""
#  })
#}
resource "jenkins_folder" "folders" {
  count = length(var.folders)
  name  = element(var.folders, count.index)
}

resource "jenkins_job" "job" {
  depends_on = [jenkins_folder.folders]

  count  = length(var.jobs)
  name   = lookup(element(var.jobs, count.index), "name", null)
  folder = "/job/${lookup(element(var.jobs, count.index), "folder", null)}"

  template = templatefile("${path.module}/sb-job.xml", {
    repo_url = lookup(element(var.jobs, count.index), "repo_url", null)
  })

  lifecycle {
    ignore_changes = [template]
  }
}

data "aws_instance" "jenkins" {
  instance_id = "i-0c8adc8341bbc4360"
}

resource "aws_route53_record" "jenkins" {
  zone_id = "Z04913851JPF0HITS640T"
  name    = "jenkins.devopsprabhu.online"
  type    = "A"
  ttl     = 30
  records = [data.aws_instance.jenkins.public_ip]
}