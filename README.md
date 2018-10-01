# yarn-distribute-example
The project contains a "Hello world" example how to distribute n-processes on top of YARN with very little code.

The implementation uses MR with hadoop streaming.

It could be helpful if you have data parallelism in your task.
Then you can split your data on "buckets" and run the same task but with only one "bucket" to process.

# How to use
1. Build project with
    ```
    mvn package
    ```
    It builds simple custom IntegerPartitioner. It is simple, but needs for the right distribution of the "buckets" numbers across the reducers.

2. Copy whole package `yarn-distribute-example` on Hadoop edge node (with `hdfs`, `hadoop` utilities).

3. Check `<yarn-distribute-example>/bin/env.sh`. The file contains user variables.
Especially check that `HADOOP_STREAMING_JAR_PATH` exists on your edge node
(if not, set the right path to the jar)

4. Start example with
    ```
    <yarn-distribute-example>/bin/main.sh
    ```

# Applying for your own needs.
1. Add your custom logic into `./bin/reducer.sh` (see a comment there)
2. Change env.sh (N_TASKS, TASK_MEMORY_MB, QUEUE, etc.).

