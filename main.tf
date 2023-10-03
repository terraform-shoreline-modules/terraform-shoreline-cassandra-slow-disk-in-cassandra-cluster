terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "slow_disk_in_cassandra_cluster" {
  source    = "./modules/slow_disk_in_cassandra_cluster"

  providers = {
    shoreline = shoreline
  }
}