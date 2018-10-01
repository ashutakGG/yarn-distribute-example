#!/usr/bin/env bash

N_TASKS=3
TASK_MEMORY_MB=100
QUEUE="default"
HADOOP_STREAMING_JAR_PATH="/apache/hadoop-2.6.5/share/hadoop/tools/lib/hadoop-streaming-2.6.5.jar"
HDFS_BASE_PATH="/tmp/hadoop-streaming-job-`date +"%Y-%m-%d-%H-%M-%S"`"
