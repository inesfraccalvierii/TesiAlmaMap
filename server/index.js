const express = require('express');
const fs = require('fs');
const app = express();
const port = 3000;

function readJsonFile(path) {
    return new Promise((resolve, reject) => {
        fs.readFile(path, 'utf8', (err, data) => {
            if (err) {
                reject(err);
            } else {
                resolve(JSON.parse(data));
            }
        });
    });
}

app.get('/:filename', async (req, res) => {
    const filename = req.params.filename;
    const filePath = `./data/${filename}.json`;

    if (fs.existsSync(filePath)) {
        try {
            const fileContent = await readJsonFile(filePath);
            res.json(fileContent);
        } catch (error) {
            console.log(error)
            res.status(500).send('Error reading the file');
        }
    } else {
        res.status(404).send('File not found');
    }
});

app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});

