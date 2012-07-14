#!/bin/sh
#
# MongoDB sharded replica set example.
#
# Two shards.  Each consists of a three server replica set.
# Also required: 1 config server, 1 mongos instance.
#
# IMPORTANT: In a production environment, this would not all sit on one physical machine, and you would need more than one
# config and mongos instance.  We also would not turn off journallin!  (We just do it here to save disk space).
#
# This script brings up the individual servers, but enabling the replica sets, shards and sharded databases must be done
# seperately.
#
# Author:   Tristan Greaves <tristan@extricate.org>

# Ensure directories exist for data storage
mkdir -p data/db/a1 data/db/a2 data/db/a3 data/db/b1 data/db/b2 data/db/b3 data/db/config

# Bring up first replica set.
mongod --shardsvr --dbpath data/db/a1 --port 10000 --fork --logpath shard_a1.log --nojournal --replSet repl_a
mongod --shardsvr --dbpath data/db/a2 --port 10001 --fork --logpath shard_a2.log --nojournal --replSet repl_a
mongod --shardsvr --dbpath data/db/a3 --port 10002 --fork --logpath shard_a3.log --nojournal --replSet repl_a

# Bring up second replica set.
mongod --shardsvr --dbpath data/db/b1 --port 10005 --fork --logpath shard_b1.log --nojournal --replSet repl_b
mongod --shardsvr --dbpath data/db/b2 --port 10006 --fork --logpath shard_b2.log --nojournal --replSet repl_b
mongod --shardsvr --dbpath data/db/b3 --port 10007 --fork --logpath shard_b3.log --nojournal --replSet repl_b

# Bring up the config server.
mongod --configsvr -dbpath data/db/config --port 20000 --fork --logpath config.log --nojournal

# Sleep 3 seconds, to give the config server a chance to initialise, then bring up mongos.
echo "Sleeping 3 seconds..."
sleep 3
mongos --configdb localhost:20000 --chunkSize 1 --fork --logpath mongos.log

echo "Initiating replica set: repl_a"
mongo localhost:10000 initiate_replica_set_a.js

echo "Initiating replica set: repl_b"
mongo localhost:10005 initiate_replica_set_b.js

echo
echo Replica sets are now UP.  There are two of them: repl_a and repl_b
echo At this stage, repl_a has been populated with test data.  Sharding is NOT enabled.
echo Please WAIT for them to finish initialising -- see the logs.
echo
echo Next step: mongo initiate_shards.js
echo

