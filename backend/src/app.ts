import express from "express";
import dotenv from "dotenv";
import pool from "./config/db"; // Import the pool from db.ts
import { setupMiddlewares } from "./middlewares/setupMiddlewares";

dotenv.config();

const app = express();
setupMiddlewares(app); // Add middlewares (e.g., JSON parsing, CORS)

const port = process.env.PORT || 4000;

app.get("/", async (req, res) => {
  res.status(200).json({ message: "Hello, world!" });
});

// Mock Route 1: Fetch All Users
app.get("/users", async (req, res) => {
  try {
    const { rows } = await pool.query("SELECT * FROM users"); // Assuming a `users` table
    res.status(200).json(rows);
  } catch (err) {
    console.error("Error fetching users:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Mock Route 2: Add a New User
app.post("/users", async (req, res) => {
  const { name, email } = req.body; // Assume JSON body with `name` and `email`
  try {
    const { rows } = await pool.query(
      "INSERT INTO users (name, email) VALUES ($1, $2) RETURNING *",
      [name, email]
    );
    res.status(201).json(rows[0]);
  } catch (err) {
    console.error("Error adding user:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

app.get("/cars", async (req, res) => {
  try {
    const { rows } = await pool.query("SELECT * FROM cars"); // Assuming a `users` table
    res.status(200).json(rows);
  } catch (err) {
    console.error("Error fetching users:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

app.post("/cars", async (req, res) => {
  try {
    const { brand, model, year } = req.body;
    const { rows } = await pool.query(
      "INSERT INTO cars (brand, model, year) VALUES ($1, $2, $3) RETURNING *",
      [brand, model, year]
    );
    res.status(201).json(rows[0]);
  } catch (err: any) {
    console.error("Error adding user:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

app.get("/counts", async (req, res) => {
  try {
    const { rows } = await pool.query("SELECT * FROM counts");
    res.status(200).json(rows);
  } catch (err: any) {
    console.error("Error fetching counts:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

app.post("/counts", async (req, res) => {
  try {
    const { count } = req.body;

    const { rows } = await pool.query(
      "INSERT INTO counts (count) VALUES ($1) RETURNING *",
      [count]
    );
    res.status(201).json(rows[0]);
  } catch (err: any) {
    console.error("Error adding user:", err);
    res.status(500).json({ error: "Internal server error" });
  }
});

// Start the Server
app.listen(port, () => {
  console.log(`[server]: Server is running at http://localhost:${port}`);
});

export default app;
