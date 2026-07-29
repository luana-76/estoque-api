const express = require('express');
const userRoutes = require('./src/routes/userRoutes'); // NOVA LINHA
const app = express();
app.use(express.json());
app.use('/api/usuarios', userRoutes); // NOVA LINHA
app.listen(3000, () => console.log('API rodando na porta 3000'));
