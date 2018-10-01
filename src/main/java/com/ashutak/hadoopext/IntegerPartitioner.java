package com.ashutak.hadoopext;

import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.JobConf;
import org.apache.hadoop.mapred.Partitioner;

@SuppressWarnings("unused")
public class IntegerPartitioner implements Partitioner<Text, Text> {
    @Override
    public int getPartition(Text key, Text value, int numPartitions) {
        return Integer.valueOf(key.toString()) % numPartitions;
    }

    @Override
    public void configure(JobConf job) {
        // No-op.
    }
}
