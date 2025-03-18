import pg from 'pg';

const { Pool } = pg;

const pool = new Pool({
  connectionString: 'postgresql://postgres:QeqC8GD8CwjSojrE@fully-stunning-koala.data-1.use1.tembo.io:5432/postgres?sslmode=verify-full&sslrootcert=ca.crt',
});

async function getStudentsByName(name) {
    const client = await pool.connect();
    try {
        console.log('Connected to database');
        const queryText = 'SELECT * FROM students WHERE first_name ILIKE $1';
        const { rows } = await client.query(queryText, [name]);
        return rows;
    } catch (err) {
        console.error('Error executing query', err.stack);
        return [];
    } finally {
        client.release();
        console.log('Connection closed');
    }
}

(async () => {
    const students = await getStudentsByName('Andrio');
    console.log(students.length > 0 ? students : 'No students found');
})();
