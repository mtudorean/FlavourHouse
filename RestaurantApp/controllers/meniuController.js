const db = require('../config/db');

// GET /api/meniu  (public)
const getMeniu = async (req, res) => {
  try {
    const [preparate] = await db.query(`
      SELECT * FROM preparate_meniu
      WHERE este_disponibil = TRUE
      ORDER BY categorie, denumire
    `);
    res.json(preparate);
  } catch (err) {
    res.status(500).json({ mesaj: 'Eroare server.', eroare: err.message });
  }
};

// POST /api/meniu  (admin)
const adaugaPreparat = async (req, res) => {
  const { denumire, descriere, pret, categorie } = req.body;

  if (!denumire || !pret || !categorie) {
    return res.status(400).json({ mesaj: 'Denumirea, pretul si categoria sunt obligatorii.' });
  }

  try {
    const [rezultat] = await db.query(`
      INSERT INTO preparate_meniu (denumire, descriere, pret, categorie)
      VALUES (?, ?, ?, ?)
    `, [denumire, descriere || null, pret, categorie]);

    res.status(201).json({
      mesaj: 'Preparat adaugat cu succes!',
      id: rezultat.insertId
    });
  } catch (err) {
    res.status(500).json({ mesaj: 'Eroare server.', eroare: err.message });
  }
};

// PUT /api/meniu/:id  (admin)
const actualizeazaPreparat = async (req, res) => {
  const { denumire, descriere, pret, categorie, este_disponibil } = req.body;

  try {
    await db.query(`
      UPDATE preparate_meniu
      SET denumire = ?, descriere = ?, pret = ?, categorie = ?, este_disponibil = ?
      WHERE id = ?
    `, [denumire, descriere, pret, categorie, este_disponibil, req.params.id]);

    res.json({ mesaj: 'Preparat actualizat cu succes!' });
  } catch (err) {
    res.status(500).json({ mesaj: 'Eroare server.', eroare: err.message });
  }
};

// DELETE /api/meniu/:id  (admin)
const stergePreparat = async (req, res) => {
  try {
    await db.query(
      'UPDATE preparate_meniu SET este_disponibil = FALSE WHERE id = ?',
      [req.params.id]
    );
    res.json({ mesaj: 'Preparat eliminat din meniu.' });
  } catch (err) {
    res.status(500).json({ mesaj: 'Eroare server.', eroare: err.message });
  }
};

module.exports = { getMeniu, adaugaPreparat, actualizeazaPreparat, stergePreparat };

