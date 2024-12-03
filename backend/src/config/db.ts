import { Pool } from "pg";
import dotenv from "dotenv";

dotenv.config();

const pool = new Pool({
  user: process.env.DB_USER || "jacobgoodall", // Use .env for credentials
  host: process.env.DB_HOST || "localhost",
  database: process.env.DB_NAME || "jambo",
  password: process.env.DB_PASSWORD || "X13Bilxzs",
  port: Number(process.env.DB_PORT) || 5432,
});

// Test the connection on initialization
(async () => {
  try {
    const res = await pool.query("SELECT NOW()");
    console.log("Database connected:", res.rows[0]);
  } catch (err) {
    console.error("Database connection error:", err);
    process.exit(1); // Exit process on failure
  }
})();

export default pool;
