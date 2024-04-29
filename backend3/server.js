const express = require('express');
const cors = require('cors');
const app = express();

app.use(cors()); 
app.use(express.json()); 

const uslugi = [
    { id:1, nazwa: 'Usługa 1', cena: 29.99 },
    { id:2, nazwa: 'Usługa 2', cena: 59.99 },
];

app.get('/api/uslugi', (req, res) => {
    res.json(uslugi);
})

app.post('/api/platnosci', (req, res) => {
    console.log(req.body); 
    res.send('Platnosc przetworzona pomyslnie');
});

const PORT = process.env.PORT || 3001;
app.listen(PORT, () => {
    console.log(`Serwer dziala na porcie ${PORT}`);
});