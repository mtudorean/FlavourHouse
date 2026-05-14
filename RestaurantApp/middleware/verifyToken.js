const jwt = require('jsonwebtoken');

// Verifica daca utilizatorul are un token valid
const verifyToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1]; 

  if (!token) {
    return res.status(401).json({ mesaj: 'Acces interzis. Token lipsa.' });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    req.utilizator = decoded;
    next();
  } catch (err) {
    return res.status(403).json({ mesaj: 'Token invalid sau expirat.' });
  }
};

// Verifica daca utilizatorul are rolul de admin
const verifyAdmin = (req, res, next) => {
  if (req.utilizator.rol !== 'admin') {
    return res.status(403).json({ mesaj: 'Acces interzis. Doar pentru administratori.' });
  }
  next();
};

module.exports = { verifyToken, verifyAdmin };
