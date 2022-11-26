const fs = require('fs')
// const { join } = require('path')
const path = require('path');

let total = 10
const imagesDirName = 'images'
const fileToCopy = '0.jpeg'

const filepath = path.resolve(__filename, '..', fileToCopy)
const imagesDir = path.resolve(__dirname, '..', imagesDirName);
// mkdirSync(folderToCreate)
if (fs.existsSync(imagesDir)) {
    fs.rmdirSync(imagesDir, { recursive: true })
}
fs.mkdirSync(imagesDirName)
const imagesDirCreated = path.resolve(__dirname, '..', imagesDirName);

while (total > 0) {
    const newFileName = `${total}.jpeg`
    const dest = path.join(imagesDirCreated, newFileName)
    console.log(`Copying current file ${filepath} to the destination ${dest}`)
    fs.copyFileSync(filepath, dest)
    total -= 1

}

