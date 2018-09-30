# yarn-distribute-example
The project contains a "Hello world" example how to distribute n-processes on top of YARN with very little code. The implementation uses MR with hadoop streaming. It could be helpful if you have data parallelism in your task. Then you can split your data on "buckets" and run the same task but with only one "bucket" to process.
