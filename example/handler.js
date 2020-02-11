const path = require('path');

const options = {};

// Since better-sqlite3 will be in /opt/...
// use absolute path to database
const dbName = path.join(__dirname, '/test.db');

const db = require('better-sqlite3')(dbName, {options});

module.exports.hello = async (event, context) => {
  const name = 'Sean';
  const row = db.prepare('SELECT * FROM example WHERE firstName=?').get(name);

  return { message: `Successfully loaded row: ${row.firstName} ${row.lastName}`, event };
};
