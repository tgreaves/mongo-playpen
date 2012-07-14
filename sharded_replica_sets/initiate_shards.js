// initiate_shards.js
//
// With the two replica sets up, add them as shards.

sh.addShard('repl_a/localhost:10000,localhost:10001,localhost:10002');
sh.addShard('repl_b/localhost:10005,localhost:10006,localhost:10007');
sh.enableSharding("test");

sh.shardCollection('test.users', { 'fave_number' : 1 } );

// Add one more row to trigger movement.
// (Doesn't look like this is needed now).
//db.users.save(
//  {
//        name : 'Mrs Smith',
//        fave_number : 20000
//
//   }
//);

sh.status();


