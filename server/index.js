import express from 'express';
import mutler from 'multer';
import uuid from 'uuid/v4';
import fs from 'fs-extra';
import path from 'path';

const port = process.env.PORT || 3000;
const dataDir = process.env.UPLOAD_PATH || '/data';
const app = express();

const upload = mutler({ dest: dataDir });

async function startSession() {
  let id = uuid();
  let sessionDir = path.join(dataDir, id);
  await fs.mkdir(sessionDir);
  return {id, dir: sessionDir};
}

async function endSession(uuid) {
  let sessionDir = path.join(dataDir, uuid);
  await fs.remove(sessionDir);
}

app.post('/tesseract', mutler().single('file'), async (req, res) => {
  let {id, dir} = await startSession();
  try {
    let file = req.file;
    let filePath = path.join(dir, file.originalname);
    await fs.move(file.path, filePath);
    
  } catch(e) {
    res.status(500).json({error: e.message});
  }
  await endSession(id);
});

app.listen(port, () => {
  console.log(`Media utils server is listening on port ${port}.  Using data directory ${dataDir}`);
});
