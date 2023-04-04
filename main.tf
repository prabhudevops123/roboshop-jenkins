resource "jenkins_folder" "folders" {
  name = "Infra"
}

resource "jenkins_job" "job" {
  name     = "roboshop"
  folder   = jenkins_folder.folders.id
  template = templatefile("${path.module}/sb-job.xml", {
    description = ""
  })
}

#resource "jenkins_folder" "folders" {
#  count = length(var.folders)
#  name  = element(var.folders, count.index)
#}
#
#resource "jenkins_job" "job" {
#  depends_on = [jenkins_folder.folders]
#
#  count  = length(var.jobs)
#  name   = lookup(element(var.jobs, count.index), "name", null)
#  folder = "/job/${lookup(element(var.jobs, count.index), "folder", null)}"
#
#  template = templatefile("${path.module}/sb-job.xml", {
#    repo_url = lookup(element(var.jobs, count.index), "repo_url", null)
#  })
#
#  lifecycle {
#    ignore_changes = [template]
#  }
#
#}
#
