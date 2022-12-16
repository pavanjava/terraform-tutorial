terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_elasticache_cluster" "redis_instance" {
  cluster_id = "test-cluster"
  engine = "redis"
  node_type = "cache.m4.large"
  num_cache_nodes = 1
  parameter_group_name = "default.redis6.x"
  engine_version = "6.x"
  port = 6379
}
