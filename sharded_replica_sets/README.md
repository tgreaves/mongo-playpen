sharded_replica_sets
====================

Relevant documentaton:

* http://docs.mongodb.org/manual/replication/
* http://docs.mongodb.org/manual/sharding/

start_demo.sh
-------------

This script sets up two replica sets (repl_a and repl_b) on your local
machine.  Each replica set has three mongod servers.

A corresponding config server is also started, and a shard server (mongos).

The first replica set is populated with some test data, via
initiate_replica_set_a.js.

initiate_shards.js
------------------

Wait for the replica sets to have finished initialising before running this
(via mongo initiate_shards.js).

This script configures the two shards, and enables the test collection
(test.users) for sharding.

Finally, it shows the shard status ( sh.status() ).  Run this yourself over
time, and look at the server logs, and you will see the hunks being migrated
from one shard to the other.

Cleaning up
-----------

    make killall
    make clean
-
