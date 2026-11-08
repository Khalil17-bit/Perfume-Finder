import fs from 'fs';
import path from 'path';
import { Client } from 'pg';

async function runMigration() {
  const migrationPath = path.join(process.cwd(), 'supabase', 'migrations', '20261108000000_init_perfume_finder.sql');
  if (!fs.existsSync(migrationPath)) {
    console.error(`Migration file not found at ${migrationPath}`);
    process.exit(1);
  }

  const sql = fs.readFileSync(migrationPath, 'utf8');

  // Check connection string options
  let connectionString = process.env.DATABASE_URL;

  if (!connectionString && process.env.SUPABASE_DB_PASSWORD) {
    const projectRef = 'muiuueqvmnljpdpaiarl';
    const password = encodeURIComponent(process.env.SUPABASE_DB_PASSWORD);
    connectionString = `postgresql://postgres:${password}@db.${projectRef}.supabase.co:5432/postgres`;
  }

  if (!connectionString) {
    console.log('-------------------------------------------------------------');
    console.log('NOTICE: Direct DATABASE_URL or SUPABASE_DB_PASSWORD not set.');
    console.log('To apply migrations to your remote Supabase instance:');
    console.log('1. Copy the contents of: supabase/migrations/20261108000000_init_perfume_finder.sql');
    console.log('2. Open your Supabase Dashboard -> SQL Editor (https://supabase.com/dashboard/project/muiuueqvmnljpdpaiarl/sql)');
    console.log('3. Paste and run the SQL query.');
    console.log('-------------------------------------------------------------');
    return;
  }

  console.log('Connecting to PostgreSQL database...');
  const client = new Client({
    connectionString,
    ssl: { rejectUnauthorized: false },
  });

  try {
    await client.connect();
    console.log('Connected successfully. Executing migration...');
    await client.query(sql);
    console.log('Migration executed successfully!');
  } catch (err: any) {
    console.error('Migration failed:', err.message);
  } finally {
    await client.end();
  }
}

runMigration();
