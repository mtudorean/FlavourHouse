const express    = require('express');
const router     = express.Router();
const { verifyToken, verifyAdmin } = require('../middleware/verifyToken');
const {
  getMeniu,
  adaugaPreparat,
  actualizeazaPreparat,
  stergePreparat
} = require('../controllers/meniuController');

// Public — oricine poate vedea meniul
router.get('/', getMeniu);

// Admin — doar administratorul poate modifica meniul
router.post('/',    verifyToken, verifyAdmin, adaugaPreparat);
router.put('/:id',  verifyToken, verifyAdmin, actualizeazaPreparat);
router.delete('/:id', verifyToken, verifyAdmin, stergePreparat);

module.exports = router;
