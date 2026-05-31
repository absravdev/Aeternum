// server.js — Backend de récords globales para Aeternum (Postgres)
//
// Dos tipos de récord:
//   * runs         -> mejores PARTIDAS completas, ordenadas por vida restante
//   * level_scores -> mejores resultados POR NIVEL, ordenados por dinero
//
// Variables de entorno (en Render):
//   DATABASE_URL  -> cadena de conexión de Neon
//   PORT          -> la pone Render

const express = require("express");
const { Pool } = require("pg");

const app = express();
app.use(express.json());

const pool = new Pool({
  connectionString: process.env.DATABASE_URL,
  ssl: { rejectUnauthorized: false },
});

async function init() {
  await pool.query(`
    CREATE TABLE IF NOT EXISTS runs (
      id          SERIAL PRIMARY KEY,
      name        TEXT        NOT NULL,
      lifepoints  INTEGER     NOT NULL,
      total_money INTEGER     NOT NULL,
      total_kills INTEGER     NOT NULL,
      created_at  TIMESTAMPTZ NOT NULL DEFAULT now()
    );
  `);
  await pool.query(`
    CREATE TABLE IF NOT EXISTS level_scores (
      id         SERIAL PRIMARY KEY,
      name       TEXT        NOT NULL,
      level      INTEGER     NOT NULL,
      money      INTEGER     NOT NULL,
      aliens     INTEGER     NOT NULL,
      created_at TIMESTAMPTZ NOT NULL DEFAULT now()
    );
  `);
}

app.get("/leaderboard", async (req, res) => {
  try {
    const limit = Math.min(parseInt(req.query.limit) || 10, 100);
    const { rows } = await pool.query(
      "SELECT name, lifepoints, total_money, total_kills " +
      "FROM runs ORDER BY lifepoints DESC, total_money DESC LIMIT $1",
      [limit]
    );
    res.json(rows);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: "error interno" });
  }
});

app.get("/levels/:n", async (req, res) => {
  try {
    const n = parseInt(req.params.n);
    if (!Number.isInteger(n) || n < 1 || n > 15) {
      return res.status(400).json({ error: "nivel invalido" });
    }
    const limit = Math.min(parseInt(req.query.limit) || 10, 100);
    const { rows } = await pool.query(
      "SELECT name, money, aliens " +
      "FROM level_scores WHERE level = $1 ORDER BY money DESC, aliens DESC LIMIT $2",
      [n, limit]
    );
    res.json(rows);
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: "error interno" });
  }
});

app.post("/runs", async (req, res) => {
  const { name, lifepoints, total_money, total_kills, levels } = req.body || {};

  if (typeof name !== "string" || name.length === 0 || name.length > 20) {
    return res.status(400).json({ error: "nombre invalido" });
  }
  const nums = [lifepoints, total_money, total_kills];
  if (nums.some((v) => !Number.isFinite(v) || v < 0)) {
    return res.status(400).json({ error: "valores invalidos" });
  }
  if (!Array.isArray(levels)) {
    return res.status(400).json({ error: "faltan niveles" });
  }

  const safeName = name.slice(0, 20);
  const client = await pool.connect();
  try {
    await client.query("BEGIN");

    await client.query(
      "INSERT INTO runs (name, lifepoints, total_money, total_kills) " +
      "VALUES ($1, $2, $3, $4)",
      [safeName, Math.floor(lifepoints), Math.floor(total_money), Math.floor(total_kills)]
    );

    for (const lv of levels) {
      const n = lv && lv.level;
      if (!Number.isInteger(n) || n < 1 || n > 15) continue;
      await client.query(
        "INSERT INTO level_scores (name, level, money, aliens) " +
        "VALUES ($1, $2, $3, $4)",
        [safeName, n, (lv.money | 0), (lv.aliens | 0)]
      );
    }

    await client.query("COMMIT");
    res.json({ ok: true });
  } catch (e) {
    await client.query("ROLLBACK");
    console.error(e);
    res.status(500).json({ error: "error interno" });
  } finally {
    client.release();
  }
});

const PORT = process.env.PORT || 3000;
init()
  .then(() => app.listen(PORT, () => console.log(`Leaderboard escuchando en el puerto ${PORT}`)))
  .catch((e) => {
    console.error("No se pudo iniciar la base de datos:", e);
    process.exit(1);
  });