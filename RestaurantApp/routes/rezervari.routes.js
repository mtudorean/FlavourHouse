const express    = require('express');
const router     = express.Router();
const { verifyToken, verifyAdmin } = require('../middleware/verifyToken');
const {
  getToateRezervariле,
  getRezervariUtilizator,
  creeazaRezervare,
  actualizeazaStatus,
  anuleazaRezervare,
  getMeseDisponibile
} = require('../controllers/rezervariController');

// Rute client (necesita autentificare)
router.get('/ale-mele',        verifyToken,              getRezervariUtilizator);
router.post('/',               verifyToken,              creeazaRezervare);
router.delete('/:id',          verifyToken,              anuleazaRezervare);
router.get('/disponibile',     verifyToken,              getMeseDisponibile);

// Rute admin
router.get('/',                verifyToken, verifyAdmin, getToateRezervariле);
router.put('/:id/status',      verifyToken, verifyAdmin, actualizeazaStatus);

module.exports = router;
