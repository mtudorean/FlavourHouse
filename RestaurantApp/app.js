const express = require('express');
const cors    = require('cors');
const path    = require('path');
require('dotenv').config();

const app = express();

// Middleware 
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Fisiere statice (HTML, CSS, JS)
app.use(express.static(path.join(__dirname, 'public')));

// Rute API
app.use('/api/auth',      require('./routes/auth.routes'));
app.use('/api/rezervari', require('./routes/rezervari.routes'));
app.use('/api/meniu',     require('./routes/meniu.routes'));
app.use('/api/recenzii',  require('./routes/recenzii.routes'));

//Pornire server 
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`✅ Serverul ruleaza la http://localhost:${PORT}`);
});
 

