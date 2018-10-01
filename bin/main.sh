#!/usr/bin/env bash
set -x -e

### Init variables.

SCRIPT_DIR=$(cd $(dirname "$0"); pwd)
MAIN_DIR=$(cd ${SCRIPT_DIR}/../; pwd)

source "$SCRIPT_DIR/env.sh"

PARTITIONER_JAR_PATH="$MAIN_DIR/target/integer-partitioner.jar"

WORKING_DIR="$MAIN_DIR/work"
mkdir -p ${WORKING_DIR}

LOCAL_INPUT_TXT="$WORKING_DIR/input.txt"
REDUCER_SH_PATH="$SCRIPT_DIR/reducer.sh"

hdfs dfs -mkdir -p ${HDFS_BASE_PATH}
HDFS_OUTPUT_PATH="$HDFS_BASE_PATH/output"
HDFS_INPUT_TXT="$HDFS_BASE_PATH/input.txt"

### Create input.txt.

rm -f "${LOCAL_INPUT_TXT}"
touch "${LOCAL_INPUT_TXT}"
UNTIL=`expr $N_TASKS - 1`;
for (( i=0; i<=$UNTIL; i++ ))
do
    echo "$i" >> ${LOCAL_INPUT_TXT}
done
hdfs dfs -put "${LOCAL_INPUT_TXT}" "${HDFS_INPUT_TXT}"

### Run hadoop-streaming.

hadoop  jar ${HADOOP_STREAMING_JAR_PATH} \
    -files "${REDUCER_SH_PATH}" \
    -libjars "${PARTITIONER_JAR_PATH}" \
    -input "${HDFS_INPUT_TXT}" \
    -output "${HDFS_OUTPUT_PATH}" \
    -mapper cat  \
    -reducer "reducer.sh" \
    -numReduceTasks ${N_TASKS} \
    -partitioner com.ashutak.hadoopext.IntegerPartitioner \
    -jobconf mapred.job.queue.name=${QUEUE} \
    -jobconf mapreduce.reduce.memory.mb=${TASK_MEMORY_MB} \
    -jobconf mapred.reduce.max.attempts=1 \
    -cmdenv basePath="${HDFS_BASE_PATH}"
