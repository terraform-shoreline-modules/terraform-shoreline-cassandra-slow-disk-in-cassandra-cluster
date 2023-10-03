resource "shoreline_notebook" "slow_disk_in_cassandra_cluster" {
  name       = "slow_disk_in_cassandra_cluster"
  data       = file("${path.module}/data/slow_disk_in_cassandra_cluster.json")
  depends_on = [shoreline_action.invoke_identify_disk_usage]
}

resource "shoreline_file" "identify_disk_usage" {
  name             = "identify_disk_usage"
  input_file       = "${path.module}/data/identify_disk_usage.sh"
  md5              = filemd5("${path.module}/data/identify_disk_usage.sh")
  description      = "Identify the specific disk(s) causing the issue by monitoring disk usage and performance metrics."
  destination_path = "/agent/scripts/identify_disk_usage.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_identify_disk_usage" {
  name        = "invoke_identify_disk_usage"
  description = "Identify the specific disk(s) causing the issue by monitoring disk usage and performance metrics."
  command     = "`chmod +x /agent/scripts/identify_disk_usage.sh && /agent/scripts/identify_disk_usage.sh`"
  params      = ["THRESHOLD"]
  file_deps   = ["identify_disk_usage"]
  enabled     = true
  depends_on  = [shoreline_file.identify_disk_usage]
}

