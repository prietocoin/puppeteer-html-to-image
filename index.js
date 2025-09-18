const express = require('express');
const puppeteer = require('puppeteer');
const app = express();

const port = 4000;

app.use(express.json({ limit: '50mb' }));

app.post('/capture', async (req, res) => {
    const { htmlContent } = req.body;
    if (!htmlContent) {
        return res.status(400).send('HTML content is required.');
    }

    let browser;
    try {
        browser = await puppeteer.launch({
            args: ['--no-sandbox', '--disable-setuid-sandbox']
        });
        const page = await browser.newPage();
        await page.setContent(htmlContent, { waitUntil: 'networkidle0' });

        const imageBuffer = await page.screenshot({ fullPage: true });

        res.setHeader('Content-Type', 'image/png');
        res.send(imageBuffer);
    } catch (error) {
        console.error('Error durante la conversión de HTML a imagen:', error);
        res.status(500).send(error.message); // Envía el mensaje de error de vuelta a n8n
    } finally {
        if (browser) {
            await browser.close();
        }
    }
});

app.listen(port, () => {
    console.log(`Puppeteer service listening at http://localhost:${port}`);
});
