const express = require("express");
const app = express();
const PORT = process.env.PORT || 5000;
const ENVIRONMENT = process.env.ENVIRONMENT || "unknown";

app.get("/", (req, res) => {
  res.json({ message: "Backend running", environment: ENVIRONMENT });
});

app.listen(PORT, () => console.log(`Backend (${ENVIRONMENT}) on ${PORT}`));